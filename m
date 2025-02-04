Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8D214207
	for <linux-mmc@vger.kernel.org>; Tue,  4 Feb 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682839; cv=none; b=AFBygJb74ol5+M7qs/+ly+7TtemS0rI8u+KsVc/v7C89w4pG/K5eev0Ux4w7dykJlRxUvqSGlHT1UnK1vIbba/nvosWTk3rgqARCX5ObDEaFlWvN5IABVt9Ox/VqC/tCMyhiDJQ95ZiewRqPazgE3b6CgSD6G2WVOqe/DF1U2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682839; c=relaxed/simple;
	bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiue5ilHrMLzO9rglamSq2RBIMt15NOOARtYtTU4V52Py09dr8V3vRjU+0mh3REHTce0AXJnlvszPOy780vETACRYFVVyRKuKASehNNeGWoUsfyEkT0yJXkHQapih4fiBtbxE3KfcyYbUzOrKRLJJ/GwSXyR/DVJvND5yU175Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UnPDSnF7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnPDSnF7"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46ebe19368so4907480276.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2025 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738682837; x=1739287637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
        b=UnPDSnF70VmXOjjZwJ0vq5JYM2h3Cx4HfuB2Ghy8hv+Y8ncaIoZikV0JxKRaUSdeDK
         aByhDeaC3zPF8Uvf9g4i3pDH/m+o0b8XCt5BeuswTI7raOjPWCE+HHNH1Db6zMEwVufb
         XtuCmyxk8l2NZSXBqelUh5gKQK6/IViY35bYhcClSOq/6ht9RG6RclNy12xequ9aLCvI
         WZayThXXrmEFmR1UGTwTWCJR75C4/Hn9RbyzyeYPq1ro62cYLV5m7Ye2mbbzuQP8W89Q
         4GhgGwU05XXswQKhsARzWOBvUhupKoEjB8h90tDw1cN5oFZh7Uny3MEYFogQP+Zj8ApW
         H62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682837; x=1739287637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
        b=Yf1PhI5WfuEjYMrnJx3qhMN+eaBMtbbacYczwoIAc/Q9zlKwQ/tphriWDLaLuc7pDX
         KFKZFj6BlKHEYZcQAZjai4/CLDOpEOLYYnNFRAPkN7lXUsIjhHWkoAjnDQ0sJ2PfiKuX
         XQ5m79Z/bARmP3bk6tXBZuOBi7jUjYikqeVay6Cxp9KELHkFMha+MRmpArFbxlFBXMPm
         GxTk3/Jwzg7Aboidu1G7zytk/qRpNFpDEV17N0uNTPnE6APXc1cegcq3rbEgWWgrKst+
         U+x6mk1gZb0lN6BTyv9RfZb3519qTeU7YxCDDDHaVOYhJ5nafgukZzL2mS0IJmQnw/GO
         hzzw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCn1s2Ac+mAqawcMwLopQH2LxhQubH7IMLrNA1KonMZpcapQVRA9YqOpM0pPaeBxCfRc7AvPdlXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4vcXk6LzsvNhe2jVazZf5CKQjjhtlF5IM+EFislg4jArcULt
	wcWi/1ziuIAY9+x0juuQRerQ0uHjMZzroMBcVzAmmAfVnuJilQqJ0CZq1OKMYjSElVog0AE33gs
	DxwL8cYZAzljKKG/JT84o6i7VPR1J/efekUYtjw==
X-Gm-Gg: ASbGncupa3vKWFM9r1sjXoewUZaUK8sk0lAM+x/x0+jZaA6XojN44lxi3+368e9PPsI
	TELeQbzsUh7iWWCZqdmdVDoYz2ijjIJ3Wn/r7V0QYe1CqypoR+EgWFkD0vtOjnkYkqvNrCvySiA
	==
X-Google-Smtp-Source: AGHT+IGuTehydOk3Axr20URL8vBy9g3qWXoLiXwzZEf5vxniYy62jE4Kl9yHuwqLqMu97MIGL+LC7qy+k9L+D/GoJRY=
X-Received: by 2002:a05:6902:2808:b0:e5a:e625:e513 with SMTP id
 3f1490d57ef6-e5ae625e61emr11909922276.12.1738682836852; Tue, 04 Feb 2025
 07:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
In-Reply-To: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Feb 2025 16:26:41 +0100
X-Gm-Features: AWEUYZmzVPGqQjAUScsSlKOO9d6YlW9_MWDY69DsffBTqZs8gHgQdoTz5D-t8mI
Message-ID: <CAPDyKFr=XyLg2VjuEq1ZTrdAwSJJmYFDn9wSFj4zWD1+ZB9MTQ@mail.gmail.com>
Subject: Re: DT property keep-power-in-suspend and how WiFi drivers use it
To: Matthias Proske <email@matthias-proske.de>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 12:05, Matthias Proske <email@matthias-proske.de> wrote:
>
> Hello,
>
> I have a question regarding the usage of the Device Tree property
> `keep-power-suspend`.
>
> In the Device Tree documentation it reads:
> "SDIO only. Preserves card power during a suspend/resume cycle."
>
> Does that mean that the SDIO Host Controller will remain powered or
> should this equally apply to anything that is connected to this SDIO
> Host Controller?

Unfortunately the documentation isn't really clear.
"keep-power-in-suspend" means that the platform is *capable* of
keeping the SDIO card powered when the system is suspended.

Depending on what the SDIO func-driver (like the brcm_fmac driver)
decides to do during system suspend/resume, the mmc core we may or may
not keep the SDIO card powered.

>
> To give a bit more background:
>
> I have an embedded board with a brcm_fmac WiFi module. It seems that due
> to a hardware limitation we are not permitted to switch the module off.
> It simply cannot be re-probed afterwards.

How did we manage to power it on and probe it in the first place?

>
> The property `keep-power-in-suspend` was used and that used to work fine
> until 92caded ("brcmfmac: Avoid keeping power to SDIO card
> unless WOWL is used"), which made the wifi adapter by default turn off
> on suspend to be re-probed on resume. Not working on our board...

Would you mind elaborating why it isn't working?

>
>
> I have also looked at other WiFi drivers with an SDIO interface and it
> seems that none of them are really honoring the `keep-power-in-suspend`
> flag. Is this flag for the SDIO Host Controller only?

See above.

>
>
> What would be proper way to implement it so that the brcm_fmac return to
> its old behaviour if necessary?
> Add a Device Tree property directly for the brcm_fmac driver..?

The corresponding SDIO func-driver may call
sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER). In this way, the mmc
core will leave the SDIO card powered-on during system suspend.
Although, unless it's really necessary, it's ofcourse a bad idea as it
would mean wasting energy when the system is suspended.

>
> I would like to write a patch, but I would like to know in which
> direction to go.
>
>
> Thank you for any feedback
>
> Matthias

Kind regards
Uffe
