From: amit nagal <nagalamit.18@gmail.com>
Subject: mmc transfer prg state
Date: Thu, 25 Oct 2012 11:44:23 +0530
Message-ID: <CABWb+VyQ0P+2sEJpXFHCofjKZ_cP6NOx7AfDJfw3gzCDdjpeag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:34206 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2JYGOY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 02:14:24 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1043955iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 23:14:24 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi ,

using mmc_test.c code ( test case 37 : Write performance with blocking
req 4MB ) , i am trying to analyse different state transitions
for a mmc write transfer size 1MB  (blksize 512 and blocks 2048 ).

Intially the card state =  4 : Transfer state . upon receipt of CMD25
(WRITE_MULTIPLE_BLOCK) , card state = 6 :  Receive Data  .
but upon receipt of CMD12 , card state comes again as 4 : Transfer state .

But in JEDEC spec , upon receipt of CMD12 , card state should first be
PRG state and after operation complete , it should go to Transfer
State .

can i be guided for :

1) will the MMC card switch to PRG state at the end of every
CMD25-CMD12 operation ? or it will cache multiple write data transfers
and switch to PRG state at some later time ?

2) any mechanism to catch up PRG state with a mmc multiple block write
transfer .


Thanx & Regards
Amit
