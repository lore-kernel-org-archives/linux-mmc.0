Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9gY6RXD"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1610EF
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 01:07:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db49ab94768so592418276.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 01:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701335221; x=1701940021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzc3U7sFDdtHUadGGzprUKVhVLAwC/gLPx8U/sb5Ft4=;
        b=N9gY6RXDkWumRhx9vouBV3yMPGyw5jXA5XNERq4YTreF8GmSxntyHyj3hPmREWT/hl
         nu2C0hSaOUHSpifnj7szzpFC/3+jXfFN4qG/K4h+wm/iRWXOqqqnjRmXiO5XNQegRHma
         03UWSvFUFOO6wNcBmeUub42q46ldRWwDyWYWwQ1Z1tWSbwvbiUS5KlHH7spR64ikt8ne
         iPGoEuMg6Xke9wL5Znb5tr9BXxMFjUUa8/l5UKSkXxwWNQwMrpQDzcTnhT+oOEZ5gyVc
         cHx/uoccDvP+WzPldhqcvw3Bxj6VJj5o008JBTqD2+iw+Qm7/fVYJJGX/fnkAYPm8vKQ
         nRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335221; x=1701940021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzc3U7sFDdtHUadGGzprUKVhVLAwC/gLPx8U/sb5Ft4=;
        b=wtjs5H770bgyBcEnVKjlCWLxYA28+lFzfIDRxZvKrPEKqXwqxgsvuHX/1zeM8Oc8ij
         URUoW6ZyAKwBwQU2LWbMT4w9rCIZcz3wFG6cSnRhsoxv31a+npzf3jNuj1w6FwAtRsNP
         UCKxZbUW05M9+YmNM1UjyeI3kq5g8Vb1Wj5L6Fuh9HQpYnbNSTd3RNGjC6v2Be7SYKNa
         /AzGPrjtqLqYLaWFmNX4YAgFi1bXomcSbGFbeivfIdP9DD/Y/eALO6+A0iRH13nVV3rn
         lwCC0AFmAgTf86HjlnVCSJNwplzZmGrKWcKAQRtf3Fpf2PkELMG2pOWCyLXfkqwsFbVG
         yL/A==
X-Gm-Message-State: AOJu0YxulRYKdKaOHAuQacNv/aHYT32EzvuZlTb1/wtm0m6b4XlE1cP+
	HYyW9c0xkewNqnUEu7Na7BG+PFUbnuTVPP6UFKpRQg==
X-Google-Smtp-Source: AGHT+IE2wHsXYey5GhKupzNswCMwI47ajmC1v7kGHta1ytzdpied8STHZJJIrUpWGsQJNpPuJQDIl8OPjlw4XfG8Ydk=
X-Received: by 2002:a25:ce0e:0:b0:db5:4196:8125 with SMTP id
 x14-20020a25ce0e000000b00db541968125mr311366ybe.17.1701335220510; Thu, 30 Nov
 2023 01:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929130028.GB2825985@pengutronix.de> <CAPDyKFqUtNEbK2tzD+qOK+dFcDyBxvcNwOHWPJDLhTWGGkoHQw@mail.gmail.com>
 <20231122112212.GA783262@pengutronix.de>
In-Reply-To: <20231122112212.GA783262@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 10:06:24 +0100
Message-ID: <CAPDyKFpWL0aVH0pfUbDiSmu=dr1NjO+wVHcTyxbQqfb52mMq2g@mail.gmail.com>
Subject: Re: mmc: handling of Under-Voltage Events in eMMC
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	linux-mmc@vger.kernel.org, kernel@pengutronix.de, Ye Bin <yebin10@huawei.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Naresh Solanki <naresh.solanki@9elements.com>, 
	zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 12:22, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi Ulf, Hi Mark,
>
> On Tue, Oct 10, 2023 at 04:48:24PM +0200, Ulf Hansson wrote:
> > On Fri, 29 Sept 2023 at 15:00, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >
> > > Hi,
> > >
> > > I'm working on a project aiming to protect eMMC during power loss. Our
> > > hardware setup includes an under-voltage detector, circuits to disable
> > > non-critical components, and enough capacitance to allow the CPU to run
> > > for 100ms.
> > >
> > > I've added an interrupt handler to the fixed regulator to emit
> > > REGULATOR_EVENT_UNDER_VOLTAGE events, and modified
> > > drivers/mmc/host/sdhci.c to receive these events. Currently, the handler
> > > only produces debug output.
> > >
> > > What is the recommended approach for handling under-voltage situations?
> > > Should the driver finish ongoing write commands, block new ones, and
> > > shut down the eMMC? I'm looking for direction here.
> >
> > That's indeed a very good question. From a general point of view, I
> > think the best we can do is to stop any new I/O requests from being
> > managed - and try to complete only the last ongoing one, if any.
> > Exactly how to do that can be a bit tricky though.
> >
> > Beyond that, we should probably try to send the eMMC specific commands
> > that allow us to inform the eMMC that it's about to be powered-off.
> > Although, I am not sure that we actually will be able to complete
> > these operations within 100ms, so maybe it's not really worth trying?
> > See mmc_poweroff_notify(), for example.
>
> Some puzzle parts are now mainline, for example regulator framework
> can be configured to detect under-voltage events and execute
> hw_protection_shutdown(). So far it worked good enough to complete
> mmc_poweroff_notify() withing 100ms window. The problem is, the chance to
> execute mmc_poweroff_notify() depends on kernel configuration. If there are too
> many drivers and devices, mmc_poweroff_notify() will be not executed in time.

Right. I have been monitoring the discussions around the series
"[PATCH v1 0/3] introduce priority-based shutdown support", but wanted
to give a reply to $subject patch first.

I think the point here is not to *always make it*, but rather try our
best to improve the situation.

>
> For now, I workaround it by registering a reboot notifier for mmc shutdown.
> It works, because kernel_power_off() is executing all registered reboot
> notifiers at first place and there are no other slow reboot notifiers.
> But, it seems to be not reliable enough. Probably notifier prioritization
> is needed to make it more predictable.

I think I need to have a closer look at the code for such an approach,
to tell if that would work.

My main concern with this, is that we need to make sure the block
device queue needs to be flushed or made quiescent
(mmc_blk_shutdown()) first, so we don't end up processing I/O requests
beyond calling mmc_poweroff_notify().

>
> So far, I have two variants to implement it in more predictable way:
> variant 1 - forward the under-voltage notification to the mmc framework and
>   execute mmc_poweroff_notify() or bus shutdown.
> variant 2 - use reboot notifier and introduce reboot notifier prioritization.
>
> Are there other options? What are your preferences?

Something along the variant2 seems to make most sense to me, but I
will continue to look at your other series in this regard.

Kind regards
Uffe
