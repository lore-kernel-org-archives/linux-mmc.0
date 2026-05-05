Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E134218BD
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983162; cv=pass; b=pN5IHhmqVQVQu3bbOEhEqMboPZxMOUezrOVMeda6orXLS0IEHio9JybV7OVmHnOK6nD82fZh5xHIPRTlv3o/FO7ngBOSgC3AT1xiWkcLoTaQmLVWDK5yoCndzvWq6y5T5p2noozUJRxszdbKZl7ke3NJFeJha20VCFSPCdIDRSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983162; c=relaxed/simple;
	bh=IXhLTtrEWjJvbg3GU0BJsb5jv7tPNvzp0Cl3DLQNO3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1QmFu5p54JHpsVx1tWmySag6MZXMgyrDhQLeReDQ5JgRSmToI5H/eyn2/cvzq1o+Hj3K3Ct/PwF+p6t0JH0UQzWG6PjUQgwnYIAFlvwxOcEFldxqRCbqb/5Pqz/Zm6xtWyFu5DddXGZUu2Jx57FEB3uH+ZDQiOhFHd5bYCsfoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPysZoqD; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPysZoqD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so5528538a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 05:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777983159; cv=none;
        d=google.com; s=arc-20240605;
        b=KiA8cRkJAlrkPMs6E3eKuvqWGKc1VMlvWzuSkiFnhI4HiAmU0h76yWxlvzTWo10RC3
         FH4/iW/V6LbviphARU7JSRBKDTZ0fFzpfhmdELTvz04jGxC3p5zj0TByIaFdqe6nn7e6
         9gdRYrGDeWiqJqVbQptNpIgFuNZxpNxvlMHrTO8n5/iFdmzfF/u2JJ9GPJPXGHMZFufc
         YUBkDnE+tdyZGhEUGxLsJfVwkFF1yyn9yRNGMDhU9IwEcvznMVKa2Fzmy97+ywbGMQd1
         81MCK+p/CQmji3gov0lwUGIq/Ra6MrYa4L4IhKm5G1rTgVB3xnPwD/t3jiP6UapeBbHW
         +ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXhLTtrEWjJvbg3GU0BJsb5jv7tPNvzp0Cl3DLQNO3A=;
        fh=FkNehUUFHM0PamyFlocxk8A5582uTEwHR5+JqEThVQs=;
        b=VjvTBJYIs/R2M0UEVLAYIBtwf2pu3LdaFnqiz0wGmzppRUMBJQdVMsV4Tv0m0jS5mU
         GZuqCH5Z0K9eZIb9ThASfy7yLJSm9imk8WjTBCkVjJuKeXziQhwPJpXzA41fMd99ahXm
         D8K7moHNeun9PCrVidaFm4FJrhYjy6yn2Zam4Npm+0A+bO+OCOnVWFSJz/KRF9y4/Qa6
         VRdcAlnBF01G8I/40nfhhrNqB5TYvZrYATUXJosonu83RHcp54Ad/ALC1DYlGTbMohSF
         tblEjyqt3X1W8cwgAcFSEA5/JVs031psMpMYd45n7h12pp9NSYpvy/E6T1FmA8ARBHLA
         b+Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777983159; x=1778587959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXhLTtrEWjJvbg3GU0BJsb5jv7tPNvzp0Cl3DLQNO3A=;
        b=gPysZoqDGQ0hTBjRdSn8uKSeb7lEcXPrgiAS/b3YoTwZapt/3s8q0ollY7PT6CGaGj
         yE1kYkxu2/MkNVJmb4EWvkp0B5GdJianJ2R1V2TVwIswiXKQ3fxlK2DrD70op+kfjpD0
         wiqQPHLsTs+G+56ah3eJQ0JWBgqHWX7nqMQhH8eFVWE11xNMGvQ8k2+baDBQWcyHINpA
         pDqVerQgBzZ4ZIPFH6h05UUCr2M5ak1iXcLDuew2REFtImzoAtJ0oFN9E7pHD39qCT0M
         KDM14mQY48Ba8xs/HMlUv5jEDV5H/0Akb/V7Td1FEO+UYlGRRaz2eaNYD+J4UOOv2W+8
         TUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983159; x=1778587959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXhLTtrEWjJvbg3GU0BJsb5jv7tPNvzp0Cl3DLQNO3A=;
        b=ZmCsF7vSo9MrSTZT+usE3umes9pL3ijkXV+aDfcfWCWaFA5Kd6VxIZ3WcG2uN2U4Pi
         NSwRx2WLt7HKZQS8KHAdQZsbC/9cBnPfeeXxKFLPMM1B9AduOYZBGQ3ziNJr4K2vTkot
         sIf+DZvgG6xi287X2VK9dSriffC4LIHv8WEp94oXFDhPSB2WQjuatIKDPUv/fHwIhd1M
         M7u6TduXPQFjaEK2M9fMQn+WLSsOtyoyiQcoPMlLKpLhzoeSAIN8pVk6OyC0BQhnnYkw
         86ftF+cnc546SZaOLYNma5RKNh+RtkBSQBy0k/VAWZK7HdZ5YdqUvbXcXsWgkRmWjY5x
         J3zQ==
X-Forwarded-Encrypted: i=1; AFNElJ8c8hFzW7gZrmkdjpdcNq8gbWPKJ7BV/ol7DmtqIP2HbUvkeDw8l+8JXeTdHYmmMgS3IrKqyUlLN8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZicw5RsqwEfX1wR89YC2jNAscmKyL3rpXplfQkoxm49m7Lu3U
	ufllFhCWN6dH1rbVjqCaqvSD/6meUCnrkEH37BcxaMxJfwd/Rkozw70IFg1dj4U2Ffe63g2VdV+
	vvuC1yDbQey3kWYy5Yg1xF+4aZ/W21xs=
X-Gm-Gg: AeBDiesXB1fBwPyZjXJAHr7n3BK1eEQKzE2/RnPQn//Nf3aVyS/YPMgiAA0JLR+udHh
	b7MxGmTXXlk0ORVfh28uwLSxu1nHnc+NsrDxnMJBnbPlgWWbWH0ps/7byAsI1MZrj6lBC+Q0Tjl
	fX3tjnqYjCCgAWCl5kUvk66+OU8xWmzLVBzRfIW+YlofZsYsSci8BbWKeJ14+z+yXyDspGhSXf2
	7MxHHrJeY2zFAj2kbWMcbZ8OftCFLHZ5hItx5uidfSbnar+y1mgK58Gy8m3NL+IjmdpZe+UeJ7j
	/rSW/kSc1rz58BluYP0=
X-Received: by 2002:a05:6402:28c8:b0:676:3cbd:1f7f with SMTP id
 4fb4d7f45d1cf-67cca82f151mr1461339a12.2.1777983158723; Tue, 05 May 2026
 05:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415123411.437450-1-a.shimko.dev@gmail.com>
 <ad-mCsvOWWgqt-rc@ashevche-desk.local> <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
 <53c62677-2185-4cac-aba8-09363d0ce9c8@intel.com>
In-Reply-To: <53c62677-2185-4cac-aba8-09363d0ce9c8@intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 5 May 2026 15:12:24 +0300
X-Gm-Features: AVHnY4Jj6mAlozYXEN_Kqp0RWdR1XNxlwQnq8cKOhnRteXSJdFxLFr3ucCaZS7M
Message-ID: <CAOPX746c1N1vsibTMW8KLJoi7BzZXuQj+yCUgApagLwmOMt9TQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jisheng.Zhang@synaptics.com, 
	hehuan1@eswincomputing.com, yifeng.zhao@rock-chips.com, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, May 5, 2026 at 2:28=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
> Only dwcmshc_rk35xx_init() and sdhci_eic7700_reset_init() assign
> dwc_priv->reset, so I am confused about what devices you intend
> this patch for.

Yeah, the change as proposed would affect other devices, and I should
not assume it's safe for them without testing. Yes, I was so fast to
send it.
My intention was to make the reset control accessible for PM
operations, but only for the specific SoC I'm working with.
However, since the custom MMC driver code is not part of this upstream
submission, the patch currently lacks the necessary condition to limit
the new behavior.

Could you please check my plan to prepare v2 to:
1. Keep the reset control moved to dwcmshc_priv (so it's accessible
where needed).
2. Add a dedicated flag (e.g., bool needs_reset_on_pm or similar) to
dwcmshc_priv so that only devices that explicitly opt in will trigger
the reset during suspend/resume.

That ensures the existing behavior for Rockchip RK35xx and EIC7700
remains unchanged.
This way, the infrastructure is in place for devices that need it,
without imposing it on platforms where it hasn't been validated.
Thank you again for the review!

Regards,
Artem
