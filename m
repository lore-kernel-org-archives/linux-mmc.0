From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: cqhci: support for command queue enabled host
Date: Wed, 6 Dec 2017 16:55:49 +0300
Message-ID: <20171206135549.uqfu3juoyzngwn46@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:55670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdLFN4r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Dec 2017 08:56:47 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: venkatg@codeaurora.org
Cc: linux-mmc@vger.kernel.org

Hello Venkat Gopalakrishnan,

The patch adcb39141800: "mmc: cqhci: support for command queue
enabled host" from Nov 29, 2017, leads to the following static
checker warning:

	drivers/mmc/host/cqhci.c:410 cqhci_prep_task_desc()
	warn: add some parenthesis here?

drivers/mmc/host/cqhci.h
   120  
   121  /* attribute fields */
   122  #define CQHCI_VALID(x)                  ((x & 1) << 0)
                                                  ^
All these macro parameters should be wrapped in parenthesis.

   123  #define CQHCI_END(x)                    ((x & 1) << 1)
                                                  ^
Same.  etc.

   124  #define CQHCI_INT(x)                    ((x & 1) << 2)
   125  #define CQHCI_ACT(x)                    ((x & 0x7) << 3)
   126  
   127  /* data command task descriptor fields */
   128  #define CQHCI_FORCED_PROG(x)            ((x & 1) << 6)
   129  #define CQHCI_CONTEXT(x)                ((x & 0xF) << 7)
   130  #define CQHCI_DATA_TAG(x)               ((x & 1) << 11)
   131  #define CQHCI_DATA_DIR(x)               ((x & 1) << 12)
   132  #define CQHCI_PRIORITY(x)               ((x & 1) << 13)
   133  #define CQHCI_QBAR(x)                   ((x & 1) << 14)
   134  #define CQHCI_REL_WRITE(x)              ((x & 1) << 15)
   135  #define CQHCI_BLK_COUNT(x)              ((x & 0xFFFF) << 16)
   136  #define CQHCI_BLK_ADDR(x)               ((x & 0xFFFFFFFF) << 32)
   137  
   138  /* direct command task descriptor fields */
   139  #define CQHCI_CMD_INDEX(x)              ((x & 0x3F) << 16)
   140  #define CQHCI_CMD_TIMING(x)             ((x & 1) << 22)
   141  #define CQHCI_RESP_TYPE(x)              ((x & 0x3) << 23)
   142  
   143  /* transfer descriptor fields */
   144  #define CQHCI_DAT_LENGTH(x)             ((x & 0xFFFF) << 16)
   145  #define CQHCI_DAT_ADDR_LO(x)            ((x & 0xFFFFFFFF) << 32)
   146  #define CQHCI_DAT_ADDR_HI(x)            ((x & 0xFFFFFFFF) << 0)
   147  


regards,
dan carpenter
