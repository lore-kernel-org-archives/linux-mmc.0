From: "Luca Porzio (lporzio)" <lporzio@micron.com>
Subject: RE: [RFC] mmc: remove bondage between REQ_META and reliable write
Date: Fri, 6 Nov 2015 15:04:11 +0000
Message-ID: <768c350f69b54c72a801584143ad1e70@BOWEX36-D.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:20338 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbKFPEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 10:04:30 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Bruce Ford (bford)" <bford@micron.com>, Alex Lemberg <alex.lemberg@sandisk.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "anton@tuxera.com" <anton@tuxera.com>

Sorry I used a wrong email/patch format.
Reposting the patch using the correct format.

>From: Luca Porzio (lporzio) 
>Sent: Friday, 06 November, 2015 12:23
>To: Ulf Hansson (ulf.hansson@linaro.org); 'linux-mmc@vger.kernel.org'
>Cc: Bruce Ford (bford); Alex Lemberg; 'jaegeuk@kernel.org'; 'anton@tuxera.com'
>Subject: [RFC] mmc: remove bondage between REQ_META and reliable write

