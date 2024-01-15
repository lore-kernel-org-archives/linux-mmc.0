Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50072208A
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jan 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncnRx2eT"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5800308276.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jan 2024 03:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705317687; x=1705922487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHPJJ8rbw0jy6/SB1odAF/HAvsBPN4MhcDWdQ5crtqg=;
        b=ncnRx2eTaPGjj+sZrYKmM/Hr98Qvrvt6GVkz4aBYVmnLxBeZEMfMyvlYAjyfbZRVSF
         2xT42dceDJ8GpreC77Ottvgq2GkXBKg9Ht/4NfobL4tOmhETN8tiB8GQFc4KBXQhiuV9
         z6S7xJDAID/HiEBChQXp2RRqwBlgeX9UQqE4N/CuE3mnilH9G4sVVKR/VoEJ2Rr/66fz
         4V1GNlTYxg18fn2hMMcPXKI8zo1n7QjG7fC4evbJloAP20/P0PUIdlFh6lgcjRHgx4cB
         r3YLvqCUsh721q3tObDDNadVzYiaSVpHLKOxrG5uT+Drb3eF9LhB8UIog93UXshv+llm
         kBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705317687; x=1705922487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHPJJ8rbw0jy6/SB1odAF/HAvsBPN4MhcDWdQ5crtqg=;
        b=gYxXE1lIFz0ieMF8d375mqENpExyoyAXZLYB8psj3sCfI1/U+WT9AYz6oAIe67035b
         MIhSqZ6DaWnqCAGgGPFg/6Ax5TFcijur4spcfGmL5bbrGrVLZrpG8iMtWSK0zC2kx8MK
         Y5w8ItW2No/GUnPnTSmsYtgiactyt0qi+bmivMzKRvTJVHHSYsk/uQr1/PeBjN2AKC9j
         YmUft1S1gmMqtCrugED577EQx6XskkoOxBUM3hYy0/xh+3sc2g5LOWAO45MMe9nis69f
         02jNPATo1crJ1bCmWmEh6rOPxvgyjB9RiOTWKqEV5NI9JRKp1C3jskUMrIlbdG3h7iha
         Ojhg==
X-Gm-Message-State: AOJu0YzJT1YdieeY+tYa+O0N1i/wdSWMlsSkE+m+HdrlBNcH0MYrXvCF
	SC/TrEwAuA5xnlEWwTmyv485Ncy5/+K3A5VSFRcYbIS5fWaxww==
X-Google-Smtp-Source: AGHT+IGOL0ZacS2Vv9hJ+pmc9qFRPH1uhFFEd/5d8YRhFSrlCkQ5oHYGr995yPkvaN9Ex2prB1ryrl1NYttEUS0gJuU=
X-Received: by 2002:a25:734c:0:b0:dbd:9884:236e with SMTP id
 o73-20020a25734c000000b00dbd9884236emr1912705ybc.93.1705317686911; Mon, 15
 Jan 2024 03:21:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
In-Reply-To: <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Jan 2024 12:20:50 +0100
Message-ID: <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Arnd, Linus

On Fri, 12 Jan 2024 at 15:22, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/11/24 10:44 PM, Christoph Hellwig wrote:
> > On Thu, Jan 11, 2024 at 01:06:43PM -0700, Jens Axboe wrote:
> >> Something like this? Not super pretty with the duplication, but...
> >> Should suffice for a fix, and then we can refactor it on top of that.
> >> ioprio is inherited when cloning, so we don't need to do that post the
> >> split.
> >
> > Yes, this could work.  It'll get worse with anything we need to do under
> > q_usage_counter counter, though.  I mean, it is a perpcu_counter, which
> > should be really light-weight compared to all the other stuff you do.
> > I'd really love to see numbers that show it matters.
>
> Yep it is pretty cheap, but it's not free. Here's a test where we just
> grab a ref and drop it, which should arguably be cheaper than doing a
> ref at the top and dropping it at the bottom due to temporal locality:
>
>      5.01%     +0.86%  [kernel.vmlinux]  [k] blk_mq_submit_bio
>
> >> Should
> >> be set at init time and then never change. And agree would be so nice to
> >> kill that code...
> >
> > I wish we could see some more folks from the mmc maintainers to do
> > proper scatterlist (or bio/request) kmap helpers.  The scsi drivers
> > could easily piggy back on that or just be disabled for HIGHMEM configs.
>
> Maybe we just nudge them that way by making them depend on !HIGHMEM...
>
> --
> Jens Axboe
>

Not sure exactly what problem you are trying to solve here, but I am
certainly happy to help, if I can.

Can you perhaps point me to a couple of drivers that need to be converted?

Kind regards
Uffe
