Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4C2253B4
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193703; cv=none; b=CEZswiCu3K+SeN7WRqF9Ii0ZVIpp153vBpf8UvT/uLjZ+DK08MzAQGNBKHRXhAyK1GbM71QvveVL1hHRYd3nc2CV5xWCfkbfTSi55anxYH9SdgkMKiqgVAgWXap/KGuXzFaGP1p2DcRiYlgRQiY/dgsPW+0Q/0Glog+ZFZhq9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193703; c=relaxed/simple;
	bh=PAbz7UvKpFEgLj5Z7hCy2WOCUWyJvYsgJPImf2cSkAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU4f5v6n6G1UldfO5nA1LsVXFd6V3Rp6LXrTMm7y2iwJJUbzQhDXL4/5r/ln7LrBphZCrhPF8ARI3gXgz0thjHCrI73U34LpyPztA7G76n2NaIczfgah2pUvS5rD6haBnUEqQ+xazzaV8IJrXkmZv2M1TVNBaGuee7KDLWw0HHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALA6V6Nq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALA6V6Nq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6ca9a3425so38167157b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 05:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739193700; x=1739798500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uSOkGddlFU/lkCcHnNp+1rcvb+cBDqhlRIZAqPb9NJ8=;
        b=ALA6V6NqTbpqeUcyRkvDFyHR3O9phqg6duCl0D43BHbZWiio9aeFsSKvo/ZqvbAGOT
         i+IlIwuFomW1Y6qS7KRk8MCuF+zk8v6qge5qtUm7EtEczXEyyggSBV96oDUXKCs3eB9K
         rhXrNNR403C2pEncKfpo5gCvnzWiddJMU6/CAgwCY51cqt4QBO1Q97LPr0ew44Z1qbEU
         23HoCSnAepJtFS39NR1QMaoJddkdw5gPJyk8BkJFfqVKiE/NNYc6D969CLCxqLZhlEFP
         8rxEEVux9hT6jA/r6hHkCKXzsMg3eOxg+Gk9yToQr8iQ80xEEtne/eDhetAdAICZbtKX
         ObTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739193700; x=1739798500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSOkGddlFU/lkCcHnNp+1rcvb+cBDqhlRIZAqPb9NJ8=;
        b=qqV0+QBLgJkBRpUC2kfZXujYLXgOJHFT/HjLQvqqz5VMX8JHqTukIvqnLsQ+phkw5/
         f3CEcOOameIUZ6NppIBmyGMfjYus4DkrdSsgDXOoRml3I9tcEaMJpANnXpph0OacY4Fh
         W0cugQwqVHX9KsCWfzThRSKRw6ioGLJORiLWL0X/6sQBlZPlUIsqKiivbT0CCiZak3x8
         bLytKsUpIe3eoTnhUv2RxWzTSQb13ziVcgZ+4f+u59epYaZxYj/92n9tHzkSqx1EHzYN
         pVkQkzdRU5br7GEfdWIiyv7LgctEWdWzgnqvc81158vTpRpQVxELgPEu2ldm9SKTAUJf
         /8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUtR7Z/4P14iBD5Agl/IHqgrNKUQzN0yX6pDYSKBXbKIOH0yz7kug9Bi4kiHajHVs9ofaSeqbqu/bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpExnW3r/xVKx1g00YKTRZVinjLQsucco1Rq5d9n7WGbL6ODy
	cDKBvao5fOLU6xTloDIx/DaJa3NZM6o+EsBM66TgVwN7KxMZP+sBDd4hozUSuwaWfMz0fQSriKa
	3yrlY9zcWUaWpytWOYo0T9YWfwIzVKPp1E7XvkA==
X-Gm-Gg: ASbGncuGxwxnk6Gzb9HK4zbI7y0jEQz0cuY1jtDd4PnAGyb5QWYFX7hD3G+lETz1q67
	AmoGaMwf5VJ3Mj/RRz4nN+uWLlCUHoH9N8vyxL8M+i6ze5HIMuk+0cfhZ1Z8SR4AtP3qa5Jla7g
	==
X-Google-Smtp-Source: AGHT+IGT/GDZ6Gxp5I3tVgS1PGL22uLGu8gT3RwgG3Vcr3l8bKWAi7Qxr4psOTaJndd7ZmGbBmIMtA2xZ5DujtxikjI=
X-Received: by 2002:a05:690c:fc4:b0:6f9:4bae:450c with SMTP id
 00721157ae682-6f9b2981b0amr124519297b3.26.1739193698224; Mon, 10 Feb 2025
 05:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
In-Reply-To: <20250206220940.10553-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Feb 2025 14:21:02 +0100
X-Gm-Features: AWEUYZmw4p2ewkot51drspCy3hd_woeZ-XwIYUHgv-bUaKg6vpiCs0WxHAlmW94
Message-ID: <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Kamal Dasu <kamal.dasu@broadcom.com>, Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	adrian.hunter@intel.com, linux-mmc@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, 
	f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

+ Jens

On Thu, 6 Feb 2025 at 23:09, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> This patch set adds support for Broadcom TZOS to read and write to RPMB
> partition using synchronized access to the controller hardware.
> To achieve this Linux OS and the secure TZOS make use of:
> - shared hardware semaphore register
> - a set of SDIO shared work registers and
> - IPI interrupt registers
> The sdio shared work registers indicates next in queue to access the controller
> and current agent in the queue. The currently running OS that needs access to
> the controller puts itself in its slot of work register and if its next in line
> it can try to grab the hardware semaphore and complete its mmc requests.
> Next agent queue state is changed under the hardware semaphore lock before it
> release it by looking at work slot register. send and receive IPI interrupts
> between linux and secure world are used to indicatecompletion of transaction to
> the waiting OS. TZOS has its own RPMB driver which accesses partition when it
> wants to read/write RPMB frames. Current implementation assumes Linux and TZOS
> as the two work agents.

We recently added an in-kernel interface/subsystem for RPMB
(drivers/misc/rpmb-core.c). The optee driver (drivers/tee/*) uses it
ro read/write frames and route them for the secure OS.

When the mmc subsystem probes the eMMC card, it registers it as an
RPMB device via the new RPMB subsystem. In this way, it allows
consumers (as the optee driver) to read/write to/from it.

>
> Change required adding two core mmc_host_ops request_start() and request_done()
> to let the host controller driver know when a mmc request starts and ends so
> that the access can be synchronized. This has been tested with both the sdhci
> and cqhci access. Currently these ops are implemented by the sdhci-brcmstb
> controller dirver to acquire and release the hardware semaphore before and
> after access. This change to the mmc/core driver does not have any impact to
> existing controller drivers.

It seems to me that this isn't needed at all, assuming we have an
in-kernel tee driver that can route the RPMB frames, but maybe I don't
fully understand the use case.

I have looped in Jens Wiklander, allowing him to comment on this too.

Kind regards
Uffe

>
> Posting this path to get comments on the initial implementation.
>
> Todo :
> - Provide  hardware smeaphore using the harware spinlock driver framework
> - Use IPI send receive interrupt controller driver
>
> Kamal Dasu (3):
>   mmc: add request_start() and request_done() mmc ops
>   dt-bindings: mmc: brcm,sdhci-brcmstb: Add sdio sharing support
>   mmc: sdhci-brcmstb: Add rpmb sharing support in host driver
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  16 +-
>  drivers/mmc/core/core.c                       |  14 +-
>  drivers/mmc/host/sdhci-brcmstb.c              | 275 +++++++++++++++++-
>  include/linux/mmc/host.h                      |   4 +
>  4 files changed, 303 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>

Kind regards
Uffe
