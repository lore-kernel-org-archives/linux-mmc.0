Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B03BED14
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955727; cv=pass; b=JpBQB4HqD0Z0HYbTqndS64sesqwwO/bY85yhpO97zVPQz8wMVYZ2tbJfNI0ftT5Ch9zjZPoyDbuFw68Jd7vndc4pQl5psSOryN6MWKaMdSDXyJe1xMeeJz7hKInigKZwbgy2my1HpN3mboSgKTBcO/lMikNJjol0AWeSX4N0a0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955727; c=relaxed/simple;
	bh=aBr9y4Yclg2KK6Io24k2AFPzMAYc7/7Xw00u+S6daV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7ohXEKX9ZaUrZMejlh0Z9dSH4Jhb6gmaeIXo5NrTDacVbh7NLjBylL+R5AWW0jqUSKlfWtjVt89JYLtt0gb63C1t+Dt76u1HziPTWtOLr5OkITelr5po2l+dzI9dKccmZR3kbgBMobadnWaOfcFRjCNGJj/WNN9uNQUv4KXTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4kwMh8y; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4kwMh8y"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso6004988e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955724; cv=none;
        d=google.com; s=arc-20240605;
        b=Ool3vdaOKNt6l+Rf3ozyHGBTp1kFCVLGcJwejl1DEC8Z5C1j2aZ1ct5sDqUbT3Xi4i
         1kPDyY6Ke+mjrlhii21r0J6kXV7RpSMjB6d9AVqcagiUV91L35mpl39yVnxFne6yX1sT
         1Qr6T73vAtju904NFHahMeL5tGuYOfDAkSy2saKmBT97YrckSBPi/UrJX2/ra74BwoT/
         qj7Tqa4i3JjmOyo9JSgDPVy6Yz7T6q63tOZ+cyELTiFsUULp83Il4ExdDgBSuhFqc+0F
         9lZPgbQc2IV3NmLcj6UTWUm4w/4QSLFyqZSSx4ElgxZo+thoYeT4a6ARYsp+JM9XmGaV
         DltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IfQ/OSSTMgqJfiqd4OnNXe/xsCCAnq3e1TuoBoN+DI0=;
        fh=pz+VZPVyusagsOFCkdMkqcuxJg3JRPJSNX+YKQTVcYc=;
        b=EeY/2I8tF+3lQ+RqSyQXPS2Exo+yRGdO0/nlaR3WP8RE1jH+UbewQBSicqDRr8ZMBK
         3YwYDerih7hhWeJrUGw9oScrptc5YRCBwraXjiFDoWH7W39lWZ4fLmXKAZ0iXoCWzDKR
         q32eXTuSR2OrVYFTxZntckGL7W9ghrBjYziAxI+DHrYiTgiXq0wBn3Zswax8DEI3Sbfh
         APBh7T4FONniEvaRazwNFGJ2jsnBk/JYCGUV0xW8iaA+yzo+5SUOvlfwQvNS8QJegwlh
         J1Gcm5fV4q/ZRGzA3jivkDxc7soeErcQL6SgXyWYNgzQo28K/5C+Po1CmOrPTSWvCbDA
         dRtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955724; x=1775560524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfQ/OSSTMgqJfiqd4OnNXe/xsCCAnq3e1TuoBoN+DI0=;
        b=x4kwMh8yGI1LVNgwv5/y+A4HI42Xr8Ohtt1bNTUYOxeP7B8CsKZ0CAuNLd4KReTsK+
         geX1MFXY7vAl0/GOaeqhvsucjhgx/1N0KzV//ovuolvT8wmOZuCBREh0Pv+A+WJH++vC
         8UB2hSgJ6oZEhafAaI+K/A0S6aYFAXu+NNwd+YvSfp0vZ49K9NEBwylTWcmtw2cz12uT
         U6E7R8OOpr/NQGEdZdE4Z3c9aeFwPTJV3XLbEV60gzlbjBJ4LB7IjiBhv2ljSvhqtwcc
         MLknrmC9AhQmGnvUEuB/tdBkIJLPeSx1TfG8BX0v+BfBd6D3S+NamFsoTChWZOirpcZw
         MXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955724; x=1775560524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfQ/OSSTMgqJfiqd4OnNXe/xsCCAnq3e1TuoBoN+DI0=;
        b=BVKKI6DAqezUExqn8VrfzVyFuJ2fN1N3jQ5VEYme+LKC+gW8tWDrPO6jPJra7Yu0LX
         T9LST8oesZv9SZBrOXD78SfYi6ykvB17j0HgHvswTiLYQ0kkwzNBvpsqrrIynDIIan/w
         qlceJtPkKN7V+EIVxOlObMVNxZeY2cB9pKSHuVWBNa98QOt8qjXudTb/7lxrKTGb1ia7
         U0vJuOuzyQbuEDjugPmAXubMDc9FGwt+KMQ4WkO5C34cpLtj+ZEXnpCcUD9CiHz5ogq1
         QgREeHWkG7Lxj+eb5CdsVJUI7sDPze5+zHv9qj2XhLWM6yANO1N4Z3Nq3MQpTHym1iaT
         QzLw==
X-Forwarded-Encrypted: i=1; AJvYcCXIfxHv+n1B8Bhj/aBA5wf5k3aSVuYKgjQS45qeGGQ4MUFuC6I+uZN6lmlq9TxfrrLlzRwZWO66uJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZUUtUTv3FARV21iJDm/YVpw9zNViH16loBklSOZ4UGwiY7l3
	r0vkL0CPGYw+HlZ/TmVdQJMcNYZ/bDfJcB/aZlDXaWWFzI8iM5YGQfhrKeicQfiJQ6153GEmQah
	oZUZ1D2NwQv2bI9cBPQLwVJBsnK5el+3Ho5JthHxCGg==
X-Gm-Gg: ATEYQzy1KmplgWppjF8kxxB6ERp2d98CVtRvLf4wRc4a9k4V5Bx33fVuv7OaJKY80XY
	QFQDHqQxsFXz13SgymLlp79pEgVvFDzdZTL+e2P907JRkyN4rmeDfrFCEkdnWhEUUE23tqBLMRO
	WYE45bCSnmL5JESd7SMUTX+H/EKBPMi3AWw7c8rBDNJMkbPIegsEe+/GpBRHaf1elxf+LFHPs0b
	iix08S35gJ1+FjlV0ZyJqfN7uOeVa27MYAgWzwmpiPCXfMljHR8GFHi9EMhtXWhDT+ROekD5nRK
	EEoQk5mwhbJE2gUf3po=
X-Received: by 2002:a05:6512:3d1c:b0:5a2:b842:6850 with SMTP id
 2adb3069b0e04-5a2b842695cmr2179137e87.15.1774955724119; Tue, 31 Mar 2026
 04:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:14:48 +0200
X-Gm-Features: AQROBzBNB9YTMIfag9Ke_wYWFHf2ISwEz1rpq1ASvrM3l06A8kjB4yA1WF4mtPQ
Message-ID: <CAPDyKFo3QHTpPv=UZfz9MdGO-Qru9eVE_rNfhkgmxJ0J4Hj6Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve request handling code flow and clarify
 function naming for dw_mmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 09:54, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> This patch series aims to simplify the request handling logic and enhance
> code readability in the dw_mmc driver by addressing suboptimal function
> naming and unnecessary abstraction layers.
>
> The dw_mmc's request handling routines currently include multiple functions
> with confusing names and redundant responsibilities:
> - dw_mci_request() serves as the mmc_host_ops entry point.
> - dw_mci_queue_request() was used for queuing requests, but with the removal of
>   multi-slot support, it no longer performs any meaningful queuing operations.
> - dw_mci_start_request() acts as a thin wrapper around __dw_mci_start_request(),
>   adding unnecessary indirection.
> - __dw_mci_start_request() contains the actual core implementation.
>
> This naming hierarchy not only obscures the true function roles but also creates
> a misleading impression of queuing behavior, which no longer exists. Simplifying
> this flow and aligning names with actual functionality significantly improves
> code clarity and maintainability.
>
>
>
> Shawn Lin (2):
>   mmc: dw_mmc: Inline dw_mci_queue_request() into dw_mci_request()
>   mmc: dw_mmc: Remove dw_mci_start_request wrapper and rename core
>     function
>
>  drivers/mmc/host/dw_mmc.c | 58 +++++++++++++++++------------------------------
>  1 file changed, 21 insertions(+), 37 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
