part of awsdart_io_unit;

setupAWSIOTest() => group('setupAWSIO', () {
      test('sets Aws.requester to ioRequester', () {
        // Setup
        AWS.requester = null;

        // Action
        setupAWSIO();

        // Assertions
        expect(AWS.requester, same(ioRequester));

        // Clean up
        AWS.requester = null;
      });
    });
