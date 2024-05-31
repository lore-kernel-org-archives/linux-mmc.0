Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A6D26A
	for <linux-mmc@vger.kernel.org>; Fri, 31 May 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188462; cv=none; b=elv4HpEzliERrpw2/yRBpWOW7YRQJBmhrJNc54vG2Dwm2rzYP6ZRthJ8d5oG3VguRBr4RkD0AWnkFhmmHDPIBsElVHjQ+aGe4FB8LnxMp5L+4oSL7fLNheMB6YHxKouJ324cYbFvCti6Vvvs9E+R84e4Qt1w1j/G5518NkaxONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188462; c=relaxed/simple;
	bh=yNgIKySXcF9/8B2sEGPTbt5GYrRbu8ygKcEU3RfpDts=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fwxMWvWS+wBVMWQtIYuAfrSsVlsuUAVzMqZ+WDUGj8Zs3oVf2uzNTdszgpgGnWOtsOSxW9rUiw6BvA8modLz4xcCBPS8TAH1wdivKOLLJPKU31s531glvQ9AwItD1592KHKs38IbO540CSwG2XvVKnKxrQE3W10T6lwkOSOFYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=BSQPGf/C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="BSQPGf/C"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a689e05b9e0so47432066b.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 May 2024 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1717188459; x=1717793259; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNgIKySXcF9/8B2sEGPTbt5GYrRbu8ygKcEU3RfpDts=;
        b=BSQPGf/C0tRnxaC8b5OQdWrfad8ZPeu7Pgwim4CqV3SibzZ8szUz/wIrMBEcIeXsCm
         p6+wHSkperV0VAul+9o4O+ofUF8Y2UUG++iVawYdNFJ4jIYCB9cms2GpQCY+HdIgYfuL
         pS/uDbfD65jZDTaTVRFbEvFegWQJzAVOnvMkke5akn5BB0SUyqfXCmqyq2nfHyGRER/O
         YDy11BWbrDVbVXut6opLehlkESlcoJr6OicfuqPBipXcrsaq9T9V9TI8m+lMfLCDSiPv
         e3P8RK0dkAkNSHINtbY4EZNN1hadBZunxNoxDOxbWSdEbJTmvp5PZx/GhAb4adcrF7ed
         YOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188459; x=1717793259;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNgIKySXcF9/8B2sEGPTbt5GYrRbu8ygKcEU3RfpDts=;
        b=wECPGuoLDs+bB4UAxfKECh6GLnIYP4KDFJPm5lgted8iswEqN8VEfJjq+lM/jzFlIT
         Aa+M0ynAVosBptmrI763STrC1WQEY/yVaPkiOMMbfpPkcBr4zhDtPSbF75bINs0xPEg7
         i0CpU5ccLjqbouulJEDT5F6pskZsf2XkRwdy0UPrzSMxhMfiq4E4RFXS/R1cGDrRTXgE
         8UkkamK7bPAgpZ/yZB87mxVSXoZBUqSyMEQuxRXMBcZ1R7nRGhtZtuxFZBcQKYYpT6tf
         oR8c7vJhy6dhGoHlP2/zTNqF5QM73MqvTPG4+p3DlYG3rA7UXb3PiL4H+AFApCyr+wba
         D+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXMoOqEKGYxpcr5MbBv12wlJDnbfN5csSA9ZlqqnYSoVC1AIbGKrVS4Ehl6jw2dF5PLoPFGfhSUOh/4HdIwCo9XONksZUtfNwwL
X-Gm-Message-State: AOJu0Yzul/NbbEDh4htibHevtNaBnobZVZGDyu6+H1KRv1xOEdkIMrtC
	OJBHuOOUylDhdIXf44RKjXRXuDsPgoxq59OvsVX5pF2J6keofL5bKC1bgnIbEKJawMUxsu/eQ1f
	5atO13oIG9Me3xz6fQvk4Ze1Bs41MRHVImkZZIA==
X-Google-Smtp-Source: AGHT+IE2ahQcykB8Inrt656onRcQdyqgq3qoX0/iS8oPBhpbEvMlHYddl9A0N3tRYB0QAdjuBhEx7BGFZCGQ59wulCo=
X-Received: by 2002:a17:906:280a:b0:a68:4aeb:e32f with SMTP id
 a640c23a62f3a-a684aebe420mr190460266b.2.1717188459047; Fri, 31 May 2024
 13:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 31 May 2024 13:47:27 -0700
Message-ID: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Subject: obscure microsd detection issue between U-Boot and kernel
To: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Linux MMC List <linux-mmc@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Greetings,

I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
for a specific set of microsd cards if I have accessed the microsd in
U-Boot with UHS/1.8V the kernel will not recognize that microsd when
scanning.

The issue does not occur with all microsd cards but seems to appear
with a large sample size of a specific card/model (Kingston SDC32 32GB
SDR104 card). I do not see a signal integrity issue on the scope.

Instrumenting the kernel the issue is that the host reports a CRC
error as soon as the first mmc_send_if_cond call which occurs in
mmc_rescan_try_freq.

I can avoid the issue by either not accessing the microsd in U-Boot or
by disabling UHS/1.8V mode in U-Boot therefore what I think is
happening is that U-Boot leaves the card in UHS/1.8V signalling mode
and when the kernel scans it sets the voltage back to 3.3V
standard/default and default timings then issues its clock cycles to
'reset' the card and the card does not recognize the reset. I'm
wondering if this is because the reset is done via clock cycles after
the kernel has set the I/O voltage back to 3.3V when perhaps the card
is still in 1.8V mode (although I don't see how that would cause an
issue)?

Is there some sort of MMC 'reset' I can/should do in U-Boot before
booting the kernel? Has anyone encountered anything like this before?

Best Regards,

Tim
