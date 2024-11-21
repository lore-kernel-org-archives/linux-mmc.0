Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0831CD1EB
	for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186760; cv=none; b=NsuSffcpO/Zo9Grk3ViO7XTzXxr5nOyqOzdD4Um8UzLVqpLHkn02xLxURgl5lQIEJm1VaEGiyBrskGILZXm5pz/GU8h4Z7U7DiYsx8SMJYZ4CxcET8dlEbX2uz1YPZkQR+rSwIFLIuFvwv6JkvsrPcLNY90ER3FYvd+ywDMkLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186760; c=relaxed/simple;
	bh=YnA/1DUcUhvDASk9V/VeCELnPCVs4RkYPWSe1KxRapU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmFFtQzVvi4fK1RPuZzPsgsxi8XRuNyCbH9CPU8TUC8lIbDCCQgTzGLXKOd8BTZk948G/4JY1dFDzUSEQxuV9Tx/zFAvTjAm50s5ErZwT5oioJHc4RoLuixFB7Me7VwtYNc8Pp/Uzg8z7spqk5FeBZ/j7uFzX5NmecudH6N/dLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfJklRSH; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfJklRSH"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e388503c0d7so627452276.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732186757; x=1732791557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHvl496Z7pSqn98+EqxZXZG+jqGpIOiw3viE2hiU7vc=;
        b=jfJklRSHD9/wkcUGX1VcRUIKvU3E8NPK8v1MW6tQ6/M8Aa4hQFuh3e1Ha1Xvlq51CC
         CgxmWD/4emVH2yAFSwtHaD10zW6AAWX2ObHuQG6uNotlAK/DbuSxWUfOz24rQof484Bq
         0ZSLRVx7Fs5l6ggaQuNned0gkgPLfJ5a4VeWwa0i6pNjL6P6WViPeWtivwZMjqrxCmVh
         n9QjiX1S8JbDlw7msafEzwIurEz2wfEt9yqpyPbk4IMkT9gu7BLqMUsRNpHoQqZD89GV
         aivaGPNjRpm8soULRPAIcHHSk1rWk5aHUkAEUe3kjh5zyF1LpNEHI6lDes3zzCuE5jzw
         4tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186757; x=1732791557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHvl496Z7pSqn98+EqxZXZG+jqGpIOiw3viE2hiU7vc=;
        b=Xuri5gqulujWGImNSh93a/RWN3LssLEtnbhOiMSezFZqEGcy1P4SqpjIp/5XiXe/iN
         WFqPQl9fE2yf+DDgfZTy8VCCOzvhLPZQgQAB+79KTX2o03ROZZpx5yWmtKvPYEnQS8YP
         J+A+57HFKdBxRYzAAinRXxwgj9NcMaPh89tYugACJN835GsidwM1b6kTcj6QYYc/Wcoa
         57azEzmY+OtmQnvW9HQ4GEWNztY2WIid/Snd43/v/LYMAF/Erb43fycGJxo5+wme6P6C
         y9msDd/R3Ue1MeG5SZ/vVEwiCv0EXIb/NAOagjFkUDj9rpP5lkS7xRNPTWh6Lqzky2/7
         /Fow==
X-Gm-Message-State: AOJu0YxEAlVAeg4IZAF/NA1IeoPQ9iu2KKAfryfM6bOHgm8BBELOo7ob
	R7fXVl2l6IfYU6Th5we6mNSFNmVSTi0bjoEweroBxzT6oC9+kCLYmFq31PEczVC4yg+ZMkr+SJs
	fql/anB8tkgUYukPkzxOnIIn8ngCzndzRWMuYR7/clHFbi3I03Xo=
X-Gm-Gg: ASbGncsnE66PoG+JDVwxqIjJMXiL23AOvAMBz2wsLzvcyIXlIQ2ExL4cBGuUIwLclMP
	tXILhrQoOjafqktH9Jqns9wLersKIEYd7
X-Google-Smtp-Source: AGHT+IElbar0KOnHQoMjtgZ9A8x6vKe5HVzOGCEKN7SP22gDNrI9hA9F1uiWE3NxT3zuXQurvUfMjHZHnCeT02pKkdc=
X-Received: by 2002:a05:6902:240d:b0:e30:d4e4:b9f0 with SMTP id
 3f1490d57ef6-e38cb70aca2mr5431005276.46.1732186756848; Thu, 21 Nov 2024
 02:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
In-Reply-To: <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 21 Nov 2024 11:58:41 +0100
Message-ID: <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
Subject: Re: MMC card detection may trip watchdog if card powered off
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 at 17:21, Anthony Pighin (Nokia)
<anthony.pighin@nokia.com> wrote:
>
> If card detection is done via polling, due to broken-cd (Freescale LX2160=
, etc.), or for other reasons, then the card will be polled asynchronously =
and periodically.
>
> If that polling happens after the card has been put in powered off state =
(i.e. during system shutdown/reboot), then the polling times out. That time=
out is of a long duration (10s). And it is repeated multiple times (x3). An=
d that is all done after the watchdogd has been disabled, meaning that syst=
em watchdogs are not being kicked.
>
> If the MMC polling exceeds the watchdog trip time, then the system will b=
e ungraciously reset. Or in the case of a pretimeout capable watchdog, the =
pretimeout will trip unnecessarily.
>
>     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301=
 flags 0000049d
>     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000001
>     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000002
>     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0: 000008=
00 00000000 00000000 00000000
>     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0=
 cs 0 Vdd 0 width 1 timing 0
>     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 0001000=
0 flags 00000195
>     [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt.

Hmm. How is the polling being done? By using MMC_CAP_NEEDS_POLL?

The above certainly looks weird. The mmc_rescan work should not be
allowed to run at this point, as the work is getting punted to the
system_freezable_wq via mmc_schedule_delayed_work().

>     ...
>     [   71.031911] [Redacted] 2030000.i2c:[Redacted]@41:watchdog: Watchdo=
g interrupt received!
>     [   71.039737] Kernel panic - not syncing: watchdog pretimeout event
>     [   71.045820] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O  =
     6.6.59 #1
>     [   71.053207] Hardware name: [Redacted]
>     [   71.059897] Call trace:
>     [   71.062332]  dump_backtrace+0x9c/0x128
>     ...
>
> CMD6 is SWITCH_FUNC and arg 03220301 is POWER_OFF_NOTIFICATION (bits 16:2=
3 =3D 0x22 =3D 34).
> CMD13 is SEND_STATUS, and when it occurs after the POWER_OFF_NOTIFICATION=
 (as above) bad things happen.
>
> I have made the following change to attempt to work around the issue, and=
 it seems to hold up, but is also quite brute force:
>
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2046,6 +2046,11 @@ static void mmc_remove(struct mmc_host *host)
>   */
>  static int mmc_alive(struct mmc_host *host)
>  {
> +       if (host->card && mmc_card_suspended(host->card)) {
> +               pr_err("%s: Skip card detection: Card suspended\n",
> +                      mmc_hostname(host));
> +               return -ENOMEDIUM;
> +       }
>         return mmc_send_status(host->card, NULL);
>  }

Yeah, the above isn't really the correct solution in my opinion.

We need to prevent the mmc_rescan work from running, which I thought
we already did...

>
> Anthony
>
>

Kind regards
Uffe
