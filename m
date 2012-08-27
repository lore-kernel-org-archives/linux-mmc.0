From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Tue, 28 Aug 2012 07:14:50 +0800
Message-ID: <CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35942 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab2H0XOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 19:14:51 -0400
Received: by obbuo13 with SMTP id uo13so9358354obb.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 16:14:51 -0700 (PDT)
In-Reply-To: <87txvox7ba.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 28 August 2012 07:07, Chris Ball <cjb@laptop.org> wrote:
> Thanks, pushed to mmc-next for 3.6.  (stable@ shouldn't be CC'd.)
>
I categorised it as a fix for a regression.

Regards,
Shawn
