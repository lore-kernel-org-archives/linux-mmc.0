Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFC26B777
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115870; cv=pass; b=Uqvgyb/PvL5W8HRJ3YaRMRi86mAzoaREtwjULb0lrdgLeb8FgajE8i5awAok4Ftm7sMiIQmpI17si/PbhZ08ssHwFlp6WE3o/pxKh4oaPeI/25knyXPWi1eAUX3HF5XNPEA/UcacvmLs8TSL3LB2iKElAwPCRMJFud27eQy/6NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115870; c=relaxed/simple;
	bh=8MG2jbMvw4wi8tAS96tW6EGOBDIklOEMSRdMXg3DPuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ/M/9C+WCVnArjGw3Ko0B322LqgCpN5IIQ04muQ7lRjVAyogVFGaqNqs0tHOvTPOxfE5q6McYl7925lI4tGUeSXqhY3fuOwpPIh0nm5Y9BNO8dpHX9Jv9mVtonEbYKsNEDNL0KvNa05JYI7L9AwZ5u9WC6+CjnudS3Xr10chw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWf2Y3UH; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWf2Y3UH"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so5013956a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 07:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779115867; cv=none;
        d=google.com; s=arc-20240605;
        b=Xage3IPw5PrsInEOqeWcuyRN6ITNMOeP4C4PLi21tuHR8Mtg9oWFYg9UX5AuZcnnJ3
         nYJg1nH64tuEtxXFLAEDxKzcqltLCdc0WT92Vm/tKmxCR0Lk/s/PCDcBb+wSeXdcsXFL
         rv09H5TQfltoszHGOssW15xXKXE/8Cv1FgoLSxjRjBOLouzNOMgN6Pw7PHKH2DvtPYag
         yMhQa29CI3lrKP5tKusv9wlxSL0bgyvzCYbTiVVYeDvfiwByuXIs/6VPnUWgOKutsBRc
         m9x8nGIj7q8Wzpj2KqfBRBgqmC5s3FxzJrqSFT8FFduIiVGs8Udis+aFyBeHH+pToIDe
         KTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8MG2jbMvw4wi8tAS96tW6EGOBDIklOEMSRdMXg3DPuo=;
        fh=EU7UtE0BoBcYkPSmIQ0DpBpwrKNW5jVrr/XvX7XjTLE=;
        b=Ue+FB2l2HUDmE3junvnGKOKhNMu50dxHmNDKOJLtCgjIx39XEwnmiXQ6A7Lz2kl4gi
         NMdNtZlKN0Frqa7TJ9OqBfOGyDUKQ27NO517BfR4hPQG7WL1zH6pdPiY0HuB76FlKJpy
         fRQnbFTPhgECxlVITYO8M3bsC+cOpDU7yDtagU09ySxaptwtjPlim8gzIFF6m0vzPGEi
         alrbLBShCm8kr0B5wZwfQ1TZuWVOib22eshx69t9+WUxdN9nHBW9BvgVlrJvVRgMbY4H
         pkb/zRFpEw/nofrsavH8ahvjR4VcvWUmd/2Om56P7lyAdGanuhUP6q9oaeksuDDLWzqr
         FiXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779115867; x=1779720667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MG2jbMvw4wi8tAS96tW6EGOBDIklOEMSRdMXg3DPuo=;
        b=oWf2Y3UH+Qo4wUqG8mDugsytAQsHv0dzMMgSVHjqDpnTYM8w7hN9d/QOuCB7YXER1j
         MrSGzO1WtCXP2Op2iYd0RffR5Ok8Bv1A8Gmh+cP/MlXLeAZX3tjeKgoeAnH0B4eqUbL0
         Jgroc1RDK8pZZUNOG9VPrIH4J7RX9D2mLYvh1JW4UpAKCzs9fsz1+kapT97tz1RX/o8R
         HdnnVHhlmnLjgM//gIiaSbALVYMlFbY8s22r5J81v48ilneUCIBh/C3K7TzemqAQHzMl
         5BVq7eink4JWDK386vxtHnLc3pbM6rMQXg3/MG9kU+tdZAhZGcCToIHnJtQya9cisunt
         nBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115867; x=1779720667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MG2jbMvw4wi8tAS96tW6EGOBDIklOEMSRdMXg3DPuo=;
        b=h0dvKneRzHyaeoerEekUhtY7ub3b0DwH1N5lbvgshowf+3cOQ4rR6IzDCCqJn6DkNA
         Zdo+RcuENnmQZSe2unkFibsN4tW3SIH3bf5aRWL/1MCMPaMNJtVKtUTLiM9TzVLMrDo3
         dm+YEw5oH29Ms/a2x0k2MsHRbvcOf6QOj4M519ZAXHXSXh6ts1MQxa+TeKw0zZTpqwAq
         zRDvEE8N5fXOGP34A/a5jCj1ZRrTuOSaNn+dLgQ4bHsXKCJf64lqISjReanwi80M4yXz
         OZnBzM18URnFV/uBwvQSX3oEE2wM+RhzD/tnGJ7B216buBU6n6gZIgUG/FrJtdaQ+f0T
         j4AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GXA6OE8KWLZX0L9PIr5PsRcrq2qZ14l+wWzUNXM/8OeFn8KtwLs/6vZob781mh8NQlMlOV0A4nMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG0rgu4Wz4tsmxkv286gcSVBdUz93kpr2IvTxjMIUFsNltRvu
	alNl3PyEiUaCFeRYY6HrSh6xOxV14QZxeehux7eiqSTYCyStMNczpjSX8A2X7DHvt2zIShMWF6Z
	0YplIfXH7kHa7SUggyLljXdlrT1Eo00c=
X-Gm-Gg: Acq92OEjRmAFIGM+WPI3k41fTaSGAywqCSp4sguucKASACTyuE2b2rjC1YNtIdB5Uha
	6TVCsa3cvL9u38aG4oc1EJkPu3ggUldRX7msFdXE6xBxRT0t8tAk/GLwj00iTbvLB0dr6FUXNjA
	deB0hctKCnQ3S6/jjqaQFvR94JXdgKuz2oqmt7kq/oYv99E8SYSXfFIYnbtOLxxOrRGDPOOkItY
	dqBiKIwqc5Lo7e2yHK33CGCkeTH+I/EyYvWQVUA84x4U3jvKttyq4MTlPzJsId/zRsayHahBoBJ
	QQXHkMKY
X-Received: by 2002:a05:6402:24c7:b0:674:28d8:11b9 with SMTP id
 4fb4d7f45d1cf-683bc0b7651mr5456278a12.4.1779115867238; Mon, 18 May 2026
 07:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-2-a.shimko.dev@gmail.com> <agsfSBAmxzd1lIg8@ashevche-desk.local>
In-Reply-To: <agsfSBAmxzd1lIg8@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 18 May 2026 17:50:55 +0300
X-Gm-Features: AVHnY4IY6Wu7AEuC1dnz-0DX4IoAQBc5hmvrPNuL-i5BTQxEWDHnwY8ZvxzpKAQ
Message-ID: <CAOPX746JbZamfeJcY+vT1EWDpFCSVe4zc8AHGL8sGobUnzC9ew@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-of-dwcmshc: improve delay handling with fsleep()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: adrian.hunter@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, May 18, 2026 at 5:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Read, what you wrote. With the above commit message this is no point in t=
his
> patch.

I tried to replace *sleep() with fsleep() API. It seems I
misunderstood the hint [1].

Or is that the commit description mistake?

Thank you for reviewing it.

[1] https://lore.kernel.org/all/ad-mCsvOWWgqt-rc@ashevche-desk.local/
--
Best regards,
Artem
