Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68053FE65E
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363423; cv=pass; b=TaDf+updbwyp5BLWegWkE0NT4Z95diNol+wN9nA0PTTk8LM5XUsnNwkT17wCUGqkqi0A8LUuH4njQlSJfi5Ay9cqNunogi6/s9fc5SVjZXcLrGfRItFp+m70qeUrdUfVRoBqbZ+UfYzCazniPEsQZByaID8B/+kjSXNj4y3Nu34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363423; c=relaxed/simple;
	bh=cKuAMo+90hQl6jVZ4oV/u2GEU9U3JPEK51CdpHE/uPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTAU74Q0MLVp6L8LBODJWkaloc3hWx/WtjDAvFuIsX5CxShWmtpH9nuyoULtFTE8Mn/jpArAKpeKMyxLIiHAGmr5OaqQCfsF54kDEkd5aLDC0/28SKIj813+2W60wIZehPiUwmgoE9dMgLndkikRI6Mg8ODGoFZGTJRui0JCCaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t95Hkx8Y; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t95Hkx8Y"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a1307438ddso4272396e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 07:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363420; cv=none;
        d=google.com; s=arc-20240605;
        b=hibG1LD1hjSLeb+730UufKtDgXf4gE61jlQdupXeJ3662G17pXTHDEUaslUpiGJ7Kh
         UgrqnK6zPFhEBr/FC6u0aHLu7cxZ4cNQObxSPa4rnIZ1nBTKhvxPjHSWUmDtK9ZD9s10
         iY6C/k5DKxIOjMjKZvRK6gGczTmzOqemycCQCPAnKstOrf5LpC4ROkQ9Zvh46efSZ8KF
         BvU17051xaTVoNKL52zgn+Vo0tWmRKOecsLXnHyHbcRdscLZHjs++Rh78Qb+sOtbVlqZ
         7vq8kLrHCIpsMUFMSktG7YWCo7OFI7Ktmez8wqhwIk+mxGOE0+Z4cYmIXCLI8sZRzwbr
         dhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hIVOW7GvJ1rBpno57ze6hheubFB8F0UsfVHddRNTrz0=;
        fh=D1exIr6KVQp91+hoE73m3FP/BXB1xLCo9emcvLsidjE=;
        b=UvcrZKD1Dt+IhFE6SwnmfUJ4r/p55wHe8QDou/P5xIUOFIuCOTDn0b3M7dH8Rhagln
         uqy9rmgESmHvxGreqV1Sst9VzjUc2g6O/eJit2+0MKriwjs4teNOY+r81VKi41zshJRD
         5+re21Xi4LHhxnM2KnTXjP3tPy5WQw5QwYpB99HW18FORAMdyDGrWATioR0C81Ud3U/T
         pj87/ws/l36FQRTx+wwJpPqrwAnApsVAbcK9E6EqZgwCmalt7fEEUhclThHLKkvBMthL
         0bz+RpGxOaVDdNU5ahz2BSZ9Tm1jAPHuA/mDFneOzNGgnVi0Xz+ekkIyXn6tTY32oYX2
         lOAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774363420; x=1774968220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hIVOW7GvJ1rBpno57ze6hheubFB8F0UsfVHddRNTrz0=;
        b=t95Hkx8Yrmuw0mezkBkzYWnnBNzXUjHURTDarkHpFj4CfdX1LCzcES4v3uzrOklemb
         s5pksjQGY5M2Xm3Mx6edkSL4HJkZj6h/E7x+pYvGNDLKRgIUYVVwL5om28rX7DgmcV/u
         6yaWOQOUwEctnXiOc9CcOLEZJIId+MmakyhnbCWIvPFmS6qezbzbNzEu3rq4aL5xV8Lu
         gTuX80JVt792CmqW2G/62YeFNWNIgZUbMSBIytIKcihuxmqU0nEQjTct6CM7WqJ2btiv
         MufKbxiFJUYCEXEcaCcKJFritL+HWJZWbLI2rDGoRqly/vuLOwRiLqKwKlWnUpKOal9P
         dQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363420; x=1774968220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIVOW7GvJ1rBpno57ze6hheubFB8F0UsfVHddRNTrz0=;
        b=CxuLxf/W390L5pgqUVLpHtHDZZhSchOqkOy+UEoF4S5+lK2Qp5kYbHqsMztR87/BBL
         PrIdzAlXez+pIvifK3VIK0gvxWb1kYJBhhOC3cl1U2XR5PigIKMLoLrGZiI1vG6tvfKh
         W3yHkW2JExqy219za7gqCflLuIp8/sNk7W/qH99sE323jxGUuEBfM/jNdkG80CgcBc9z
         +2bArFysaRW3IGbaCfXEkHRjOZqy2lvnk3Wh2QksjVajGFZ/nQpikycQprqAupaBfDoC
         sB/nZucbWo2FS92u4tU4rfkPKG7blbjDIEIZGQPCVOWa2nZow1enKuhMMC+H7rfNpsH3
         DTtA==
X-Forwarded-Encrypted: i=1; AJvYcCWSIek8h7sR5oJWHh4MrnhC2yReWGZUqHRaODRgLhGfe34+ZFSO9g8Aq0MYeUWdwdVdlZJKH1aMEA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZH+X9vjN93hdNumdMAk3gGffudaXuTKVfEMxmhvP5qIVirxM
	LGgHqZ+a0RdxvfqTaJFlnW0rmjbqc0OF2xW1ts1rdvwAIgjVRsHc0f/jCXn3SukJ1WY0/rhQg+h
	1O6TEWzFARYsD9fTStDPsLE7WySn4T/J7zY+Xe35KwA==
X-Gm-Gg: ATEYQzxy2CxskDGOAnEZn8glHbMh7ICfdIOLJYaQwVOW1bosC21lm8BjjDqizp9aP91
	mZ4640dCMrdVgSitnX6F0OuIsLCMor9Do+VSttYYKJyuBegcjYEFrvJVHE9wEyop9P9DLSOGSWx
	fqxB7Jtg94d+3ur+77HV1IbEdjUTYPCBsl6fyKAa1CJeByBvWCYDqvvp97Kqecs7TM0F76v5lZq
	YxIEMT9HJdYuSPm/68SVW0dqO2zBSG0uS2bI42miXQ/FFUYRmJbZnJW1euZW7O8OJnjhILcnaPg
	pJjZ2RvB2VDF8cSM2V8=
X-Received: by 2002:a05:6512:3d19:b0:5a1:ea0:afa8 with SMTP id
 2adb3069b0e04-5a285b5dbf3mr5614955e87.40.1774363419882; Tue, 24 Mar 2026
 07:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com> <20260323-orangepi-sd-card-uhs-v4-2-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-2-567c9775fd0e@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 15:43:03 +0100
X-Gm-Features: AQROBzCfUpt1ZwyBkuHwcMICLYcYLjpRhE9JmTUslsPEwhDJl3mjCswU4lxnLwg
Message-ID: <CAPDyKFqirdKWZmxO15B6MvH75zsQgiwM-6Ux0PiCuxZsfNBUfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 11:19, Iker Pedrosa <ikerpedrosam@gmail.com> wrote:
>
> Add voltage switching infrastructure for UHS-I modes by integrating both
> regulator framework (for supply voltage control) and pinctrl state
> switching (for pin drive strength optimization).
>
> - Add regulator supply parsing and voltage switching callback
> - Add optional pinctrl state switching between "default" (3.3V) and
>   "state_uhs" (1.8V) configurations
> - Enable coordinated voltage and pin configuration changes for UHS modes
>
> This provides complete voltage switching support while maintaining
> backward compatibility when pinctrl states are not defined.

Adding pinctrl support like this should require an update to the DT binding.

Please fold in a patch that precedes the $subject patch and ensure the
DT maintainers are cced on it.

>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>

Kind regards
Uffe
