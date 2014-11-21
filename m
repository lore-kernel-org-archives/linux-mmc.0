From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: FFU for eMMC v5.0
Date: Fri, 21 Nov 2014 14:07:44 +0100
Message-ID: <CAPDyKFqHUC0nd2XwEohth9Py7y+=UA4x8qn7nGYxFNCTD1xZkA@mail.gmail.com>
References: <1415896135-27114-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:44973 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbaKUNHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 08:07:45 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so4101329qcw.34
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2014 05:07:44 -0800 (PST)
In-Reply-To: <1415896135-27114-1-git-send-email-avi.shchislowski@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <avi.shchislowski@sandisk.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 13 November 2014 17:28, Avi Shchislowski
<avi.shchislowski@sandisk.com> wrote:
>  The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
>  JESD84-B50.pdf)
>
>  http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc
>
>
>
>  * This solution allows to:
>   - Complete eMMC 5.0 FFU procedure as an atomic operation, without being interrupted by other IO requests
>   - Not limited Firmware data size. Using Multiple Write operations.
>   - Support of both EXT_CSD_MODE_OPERATION_CODES modes
>  * The solution is using "udev" device manager to transfer FW data from user space to eMMC driver
>  * Pre-existing functions from mmc_test were used in this solution.
>
>  *New ioctl has been add:
>   -transfer the new Firmware data from user space
>    to the eMMC deivce and install the newfirmware.
>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

Guys, this isn't working. I am unable to review your patches!

1. I don't know what the patches do, because the commit
messages/headers are really poor.
2. Patches are too big.
3. You are mixing logical changes into one patch. Like when you move
code and change code in one patch. That's two different things and
thus should be kept separate.

Please go back and re-work this thoroughly before you decide to send a
new version.

Moreover I also think you need to read
"Documentation/SubmittingPatches", that should give you some more
hints on how to improve and help me as a maintainer.

Kind regards
Uffe
