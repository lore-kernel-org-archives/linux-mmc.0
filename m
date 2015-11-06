From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: mmc: Improve reliability of HS200/HS400 selection
Date: Fri, 6 Nov 2015 12:03:59 +0100
Message-ID: <CAPDyKFoXaKdBzQnZNiqf-39+zECtGPY5M8S7_BL8eUkaoqKN9Q@mail.gmail.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36694 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFLEA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 06:04:00 -0500
Received: by ykba4 with SMTP id a4so179605117ykb.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 03:03:59 -0800 (PST)
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

On 28 October 2015 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some patches that improve the reliability of selecting
> eMMC HS200 or HS400 mode.
>
> Generally the improvement is to match the host controller timing
> setting with the card mode before sending commands.
>
>
> Adrian Hunter (4):
>       mmc: mmc: Improve reliability of mmc_select_hs200()
>       mmc: mmc: Fix HS setting in mmc_select_hs400()
>       mmc: mmc: Move mmc_switch_status()
>       mmc: mmc: Improve reliability of mmc_select_hs400()
>
>  drivers/mmc/core/mmc.c | 93 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 24 deletions(-)
>

Adrian, these patches looks good to me. I plan to queue them for 4.5
but perhaps those should even go as fixes!?

Additionally, it would be great if someone could help testing this on
a few platforms.

Kind regards
Uffe
