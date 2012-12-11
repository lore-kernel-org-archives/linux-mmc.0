From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: FW: [PATCH v1 0/3] SDIO fixes
Date: Tue, 11 Dec 2012 18:11:31 +0530
Message-ID: <50C729FB.1090107@codeaurora.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org> <50C7271D.2080704@codeaurora.org> <86988B169C1CD04598F5B80198CCE50E738D93@aphydexd01b>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35252 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab2LKMlg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 07:41:36 -0500
In-Reply-To: <86988B169C1CD04598F5B80198CCE50E738D93@aphydexd01b>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm@vger.kernel.org, johan.rudholm@stericsson.com, ulf.hansson@linaro.org

Hi Chris,

Can i request you to merge following 3 patches to mmc-next? Ulf have 
acked all 3 patches and Johan Rudholm also reviewed one of them.

Regards,
Subhash

>
>
>
>
>
> -------- Original Message --------
> Subject: [PATCH v1 0/3] SDIO fixes
> Date: Tue,  4 Dec 2012 17:06:17 +0530
> From: Subhash Jadavani <subhashj@codeaurora.org>
> To: linux-mmc@vger.kernel.org
> CC: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>
>
> This patch-series is having 1 fix for SDIO resume and 2 fixes related to SDIO3.0 card detection
>
> Subhash Jadavani (2):
>     mmc: sdio: fix resume failure
>     mmc: sdio: print correct UHS mode during card detection
>
> Sujit Reddy Thumma (1):
>     mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
>
>    drivers/mmc/core/sdio.c  |   33 ++++++++++++++++++++-------------
>    include/linux/mmc/host.h |    8 ++++++++
>    2 files changed, 28 insertions(+), 13 deletions(-)
>
> --
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

