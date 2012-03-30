From: Jonathan Woithe <jwoithe@just42.net>
Subject: Possible issue with tifm_7xx1 and interrupt latency
Date: Fri, 30 Mar 2012 22:09:15 +1030
Message-ID: <20120330113915.GE9075@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: oakad@yahoo.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jwoithe@just42.net
List-Id: linux-mmc@vger.kernel.org

Although somewhat circumstancial, during the debugging of a FFADO issue with
a user it seemed possible that the tifm_7xx1 module may have been switching
interrupts off for long periods of time.  For a full history of the problem
please refer to

  http://subversion.ffado.org/ticket/250

Unfortunately the original reporter no longer has access to the hardware
concerned and the report itself dates from 2 years ago (I kept forgetting
to report it).  However, it may be useful none-the-less.

Please CC me any replies.

Thanks
  jonathan
