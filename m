Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65E3BD245
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279210; cv=pass; b=qukHBEDom8se7hbWweAQCTSGK39vcK6rWCnc/vpsD6L9fV4p8evker4yASGlXuuFtbiKVRWeJDxDDU9dNPG/5UhlgjZlz2P1myVLPLmS+LX0bXaDHs3yMqIDAFeokWoF6rU+9jTMlimPzVYpvu3AzfhhI7UTFu1aweXR7qDKW7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279210; c=relaxed/simple;
	bh=WTGNsJXJENGSXqHyqYqrSL+FmpM4f+NO/Gh4/YenkBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQLzMuTT80e0K4B2BtElkaScJMSZKzyfx66FjI2X6FRAEy9zkR8i5YYBIWhe/cNbr0ad9ich4JpzIu6GK6P78do/lYlrke4ysrLzFT1OxlFeibVeiJ9eME8QA7be53KqCgMyYNXEUIKNIGUPb8K/lI9sNjD1ue55i2V73e8A3SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrBwZVRp; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrBwZVRp"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so29122331fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279206; cv=none;
        d=google.com; s=arc-20240605;
        b=kyZahrHXrABKECqtY/JCixKmbz/kx/vKHpUqIiIwlOb4R+8hRCYP3fz5cz1VmaAv1z
         Qi8b5bdKhFLlbn86gOeBrWRH27Z/HhOhS3dYgUXariBWFJzSTh1uwg6zfcXtVk24ajXe
         Uwh7tluF58D7cMqhE3hFEVyi2C5nvoHhfZhwxhBbyjVaC7+R9v3RVUgysz9BmgQPEvoK
         W7Zj7ueuKFVMiF4xCJo517zLCmn/deI5Wx44wKNlLXrOSyvPvpVl7GJ92gDGimod+rd/
         +EjAbhvQs+rRN1oKDb/JGKUkCUNnRylHlCllNmLFCtU5+2uD51oiHh19tGz3rQI5uBEA
         Q89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CFEoClYNIUTw25SNi2mfbHdMYgsaJ4yJesVezbduu2c=;
        fh=LeJN+jhGL8bh98KphiSFTSkReg98d4Cs5k6FoGtwhl4=;
        b=DxaZekng60Cg2LDLVp+hlxg2vo8z8NPWKXW5hxi6K0G99VZBQczXmlbDLWWHH9Vc/G
         964VHw7jbhtQwJjnnn/7jKORP1nS5PWo09NwDJ+N5wFVbWP01DAcoOxtRQM2YFlVeC3O
         Yk1YVWbTqRtw3Pthsdu7eecWyGTQ9Yis8+I1L7Zn3fU8+QeB5mIPW0l/+SNMeV0O6JBj
         jmRHC7WBO7ASMRK8J47A35tN8xPxYHdhCVJmZVA36IozcRNKjyBTsnOkPguD30Cw2lOw
         6884VIJrW2au5pw9l8EgcZQRuFKm64lvnbiFVbEY2OB+3EK01eRP864WWZFQ6eVbIgt0
         YrCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279206; x=1774884006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFEoClYNIUTw25SNi2mfbHdMYgsaJ4yJesVezbduu2c=;
        b=MrBwZVRpM993zSzLfLmViuNx5BiLjjHznWg0sfKNlhIKGW6Gm7B+kyp9Fx4OrPXWth
         joY8Y6KHNCIJgkdmTohQxY5wKgFTPT+CyslZmVlK88+7WrgSTyHoYLJgdlfo1l8GAplp
         UOwpnC6g03Li6xyEGZBWKcwgHxu1d6yKgbY/Ki7OuAh8sMhFz2i4qt8Ahb6T/uT7MNmu
         NKUNf1OraeRqi9bPvVoXhpB64cQzPmJJu7z8iSZ8/o49G92ZLstI52UHUuaQPrlh+nB3
         +blbQr510/JNiMmTie3m3nwvc+idzeQ8l3xoxB0OWC0RbhtY8MJWbWrXWvOfwX9+lP/9
         T0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279206; x=1774884006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFEoClYNIUTw25SNi2mfbHdMYgsaJ4yJesVezbduu2c=;
        b=VQbolfgrAQIPbF1ttcgnME/WLbF5D3f/X0Q0SR/jL/gqCwI21w3CSMymPi4yT1qgo3
         hV9naqOCl9bNedGlKOtMNSNrzLPU/M2Q/uXH62N8RU9P6brPDRAzjOafQxnBypvy5Fl1
         eOsyE1bp36v2rcQmEhyFI9B9xwRJBRBmyCZz18pd84Tt+3SkSNlD6Te6fbe6GkbrC1Bl
         iWZSjjLWFeX6q72TMubqeSWl66WunLWPUZZUwMvxAJyguKBBC2tes8UBMIehvvHkEGSs
         xqFEsPq4yYPpY5wiiy86l8bW4pPxBEMapiqyl0UY55RJ3DwBG4bfrJ1hna0aBCDlDcEM
         49xA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1B8dqWn2oB32MCvD0NYUG2CjC4+aOl0/mF44mUll9E60+VehPGDA8yorq1mB4MUwGz4wBbYxvzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBoIPIA3SHaYXtmF0G1H8H9Dkz+sgUepGZLW92dD3ETZuPcCq
	YbZDOdxm1ZjMNvoQgFiC9CqiSyLrYuGMdZjkAw4KifzF9d6GJBTu8oyGpPD/OlFd50Larf2ytIr
	PqaFykg9haJE3bENLNuL08T5/V0YLqqDQx/D2jclzxw==
X-Gm-Gg: ATEYQzx530rH+IaM7gYtn3zHXs0Y0aD5CInINbaHjDdtQe4VYwsAPhjvzhW5sCZFTgn
	N3Z/ZNdW0+pWjI8zDQOLxQ62ZcVRZoQ2Zv4YPyAlX1tSJef5nKCQRNdT0K2cH5mfmj+L8HZOU/8
	1CDSitS4KeF8YOOwJs93vp61O/oh6UDsWPihDlGbUSOv20/I98qyM4NELRNTVJ50aQacB9JPi0/
	LjAZgd4F7sbFJa6+z4ECg9tsNwclfddFCSUlprOdHLDYpzvLkWdoeP6hnzgXrVBPbgjciuJS2bN
	OWVpYCEn
X-Received: by 2002:a05:6512:318f:b0:5a2:844b:d47e with SMTP id
 2adb3069b0e04-5a285aef82amr3653607e87.1.1774279205615; Mon, 23 Mar 2026
 08:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:19:29 +0100
X-Gm-Features: AQROBzCxqxYpN265mvRUOBDK4WaVcKkSk3vYCZgRowThX_rFJS728bgruXKnriM
Message-ID: <CAPDyKFpBRjfS3QuUhLxwBAJfwg1dyraPpR6+L2RDOKj554Ytgw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add SDHCI support for Canaan K230 SoC
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Cc: krzk@kernel.org, adrian.hunter@intel.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	gaohan@iscas.ac.cn, me@ziyao.cc
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Mar 2026 at 15:07, Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn> wrote:
>
> This series is based on the k230 usbphy series[1].
>
> This patch series adds SDHCI support for the Canaan K230 SoC,
> which uses Synopsys DWCMSHC SDHCI controllers, include MMC0 and MMC1.
> The hardware designs of these two controllers are different.
> The MMC0 supports eMMC, while MMC1 only supports SDIO. Detailed
> information can be found in the vendor's manual[2].
>
> From the vendor's K230 manual:
>  - MMC0 supports eMMC5.0 and SDIO3.0, usually for eMMC chips.
>  - MMC1 only does SDIO3.0 in 4/1-bit mode up to SDR104, and the manual
>    clearly says it can't handle eMMC because of pin count and limits.
>
> Therefore, there are two separate compatibles and the driver treats them
> differently.
>
> Link: https://lore.kernel.org/all/20260121145526.14672-1-jiayu.riscv@isrc.iscas.ac.cn/ [1]
> Link: https://github.com/kendryte/k230_docs/blob/main/en/00_hardware/K230_Hardware_Design_Guide.md#mmc-circuit [2]
>
> Changes in v5:
> - Drop the unnecessary line wrapping.
> - Drop k230_priv->k230_pdata.
> - Make a macro to uses container_of for pointer type conversion.
> - Add the tested-by tag.
> - Link to v4: https://lore.kernel.org/all/20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn/
>

Patch 1 and patch2 applied for next, thanks!

[...]

Kind regards
Uffe
