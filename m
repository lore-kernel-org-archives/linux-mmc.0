From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v4] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Fri, 26 Feb 2016 14:37:44 +0000
Message-ID: <867fhredvr.fsf@void.printf.net>
References: <89e1e3481efb45327716d76dd16a05ace046c083.1456205801.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:56718 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbcBZOpI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Feb 2016 09:45:08 -0500
In-Reply-To: <89e1e3481efb45327716d76dd16a05ace046c083.1456205801.git.baolin.wang@linaro.org>
	(Baolin Wang's message of "Tue, 23 Feb 2016 13:37:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, sebras@gmail.com

Hi Baolin,

On Tue, Feb 23 2016, Baolin Wang wrote:
> From: Sebastian Rasmussen <sebras@gmail.com>
>
> The lsmmc tools contains an extensive parser of the CID, CSD, SCR
> registers from userspace. The utility works as-is and uses sysfs
> to read the register values.
>
> The original code is created by Sebastian Rasmussen and still lives
> in an attachment in the mail archive of linux-mmc. It need to be merged
> into mmc-utils repository, which is convenient for testing MMC device
> from userspace.
>
> Change since v3:
>  - Remove the unused EXT_CSD parser in lsmmc.c file.
>
> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> Signed-off-by: Chris Ball <chris@printf.net>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

This is merged into mmc-utils now.  Thanks!

- Chris.
-- 
Chris Ball   <http://printf.net/>
