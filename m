Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2C1DE2A2
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399993; cv=none; b=CO5IJ3FXL0OQJ1kNlVkcG54zM0ArtP4xsOEu3efl4HW37/cNdRTXpW+nYUuXO6I1eTzCbQBpAqBNUWqWuEPjPAeD2D1agG2hAB/FOLiipWWlaPgETp6Iput+p7Kf1n7UZbyTkj4xa2Yy+EwvPuIh8HN/BNfRWUSSnzer1Xy5OqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399993; c=relaxed/simple;
	bh=N83QClFj6vSbJUe35YQ6xzEaQoaubcuiXwjOBMZHnWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcqOSOJacqCTzwk70XedPjkdzHDD+HkfFDTB1wwp4vGQI5VshB/3QdEC55CipwjqFU/8LvCh0ac6TRP68eau/I9xEGufb4N06qJyBXP/BdMhaB8vjCC52GVSWlZovRvd+I551n16JJbgnjVQyjXHv2SxI7OW7/3pneYgZi4szfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LNjdwfg4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNjdwfg4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53959a88668so7218070e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728399990; x=1729004790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N83QClFj6vSbJUe35YQ6xzEaQoaubcuiXwjOBMZHnWU=;
        b=LNjdwfg42wjhY9KRjUx2je5rkUPX1SSqIQs+8E5RQqwfH/NH+uptIXCsfueCYBMzL4
         dPs3JBiZFwNGO9QMw22bXGfBxUPbtIkORHbPNGBHtcgGZ7pqzGF6yWU4+/r+EDggNuyJ
         mOzkdKbChc04rLwwVcdbuGbEkCV/WlE0rK1514IdG0fglrLks9bBKLayoZB9HblSyImG
         96xXahvt3bWdwEig2T0ri2sKv62VkDx4/uP+d29IDovxVxW3oUHNBa4/b0NV5qOH/4j7
         jApJbe7E8mbThy5BmJIs9tP+zP0QqT016sscInldrcJtdQ0sEjHoD2ypUEdg1ZOIJUT5
         klqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399990; x=1729004790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N83QClFj6vSbJUe35YQ6xzEaQoaubcuiXwjOBMZHnWU=;
        b=oOr/78Fo+H0Cdsva+WdaldGCojFf4DnVjULUkN45jPB9ffdqBNd8Ki+IBO81u5Dcm7
         TSyg04ZrBGxmm0LazNjf6RoTC0UKMhf9hj1cdWg0ZTwy006Yixo9N+nHt7xCujLZqYIC
         QlFCzdIFgN3bLdDtkse1fo69Fr27e4OsGpyzHganhcrVL0QI1e2PsxIaV9Xcv/gIEFdf
         6ktXBZ+uK3/yNht2k5nwSoWtmX839s26g0VbHTWOBfQ26Mdrxvlvw7yFc3xNbCRT+uvt
         3Dr4djDXriY4Chhb6FDAGPn5SJdUDjgE3jA582QII6Lv8P8nDw2JnmgsS1goXtcRjakW
         823g==
X-Forwarded-Encrypted: i=1; AJvYcCXVCFp4WF76dNSk2L9GT1vP3LyrTqJDpZtWGb4wfkaUcV/nrk1ggMz6alCd/tPrR6Jd6mihdzMiaj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWyFYqwKYwBT9ygv8sFVf2iYAefp7/3kpYgaqTvSa/il2VFEu
	RrE0L32CoX0FD0yZwDBCzHCFnoNpIX8IJPxEkRBJ+tM0XvfY6L7ofGaXrKDGk7xAJkI9leCxxEu
	1bJYgYd4ceN2bAHxUth6MS9M6fLTIwaZtC1Vn1w==
X-Google-Smtp-Source: AGHT+IHPUH95vercgubmJyozHmL7N08Yp+6zUsDN+9h5501JG4VP8+DOvKWh9h17WjKnR/vaEzMRsx87YDdNZDb1P4k=
X-Received: by 2002:a05:6512:1387:b0:530:daeb:c1d4 with SMTP id
 2adb3069b0e04-539ab85c0fcmr8672320e87.12.1728399989667; Tue, 08 Oct 2024
 08:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8235497b-421c-4af7-90e4-95ad4e271ead@tuxedocomputers.com>
In-Reply-To: <8235497b-421c-4af7-90e4-95ad4e271ead@tuxedocomputers.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 17:05:52 +0200
Message-ID: <CAPDyKFrT6-nes784c9rCtqdJZ0nCFS3O5X=600OB6trbz2yJ2w@mail.gmail.com>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: victor.shih@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

+ Ben

On Thu, 26 Sept 2024 at 17:31, Georg Gottleuber <ggo@tuxedocomputers.com> wrote:
>
> Hello,
>
> I have a problem with s0ix sleep on a laptop with GL9767 SD card reader.
>
> The device is a TUXEDO InfinityBook Pro 14 Gen9 Intel laptop and
> consumes 6 watts in s2idle (not reaching s0ix). If I blacklist sdhci_pci
> in /etc/modprobe.d/blacklist.conf then the device sleeps with 1.2 watts
> (this is not super good, but OK). Unfortunately unloading and reloading
> does not work either. Once the module has been loaded, the high power
> consumption remains, even after a rmmod.
>
> I tested this behavior with linux mainline 6.11,
> 6.11.0-rc7-next-20240909. Kernel mmc/next does not work either.
>
> In an AMD device (InfinityBook Pro 14 Gen9 AMD), however, the same card
> reader sleeps without any problems.
>
> Link https://bugzilla.kernel.org/show_bug.cgi?id=219284
>
> Any ideas?

I am sorry, but I don't have any useful suggestions at this point. We
need some help from the guys from Genesys Logic.

>
> Kind regards
> Georg Gottleuber

Kind regards
Uffe
