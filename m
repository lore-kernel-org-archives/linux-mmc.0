From: Meng Wang <meng@tupleapes.com>
Subject: execution order of packed command in eMMC
Date: Wed, 6 May 2015 14:16:14 -0400
Message-ID: <CAP3VVE1idbQ2fLw1wpEBnuJiprGa0L46OuzR_Ng6zc_yxyfcRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33456 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbEFSQP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 14:16:15 -0400
Received: by oica37 with SMTP id a37so14458493oic.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2015 11:16:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

Recently, I am working on eMMC device driver. My question is on the
execution sequence of the packed commands. According to the emmc 5.0
spec,
```
6.6.32.2 Packed Commands Error Handling
If one of the individual commands causes a failure, the following
individual commands within the same packed command are not executed.
```
it seems to imply the execution of the commands in one pack is in the
sequence that they are listed in the packed command header. So when
error happens, I can safely assert it is completed for the first
PACKED_FAILURE_INDEX commands in one pack. Is my understanding
correct?

Thanks,
Meng
