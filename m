From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Tue, 28 Aug 2012 09:50:13 +0800
Message-ID: <CAAQ0ZWTjW83tFO8Ou9bffmHjPqd61GYg-yBjxmk=2HKzt_WFKg@mail.gmail.com>
References: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
	<87txvox7ba.fsf@octavius.laptop.org>
	<CAAQ0ZWSpxAn+F45C_tuW1Co1370-DVb=dXSzDt9GBy9Mq_vLqg@mail.gmail.com>
	<87ehmrykv8.fsf@octavius.laptop.org>
	<CAAQ0ZWS34QtkOGgidi=PyKX3=xHxRYdU+AQgV4kK9pJyeSCtHQ@mail.gmail.com>
	<876283yhjm.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44727 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2H1BuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 21:50:14 -0400
Received: by obbuo13 with SMTP id uo13so9545526obb.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 18:50:13 -0700 (PDT)
In-Reply-To: <876283yhjm.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org

On 28 August 2012 08:41, Chris Ball <cjb@laptop.org> wrote:
> So, as I understand it, you did the right thing in having "Cc:
> <stable@vger.kernel.org>" inside your commit message, and the
> wrong thing in sending the mail to stable@ at the same time.
> That's why I removed it from CC.
>
Ah, ok.  So it seems that I should have --suppress-cc in the git
send-email command for such patches.

Regards,
Shawn
