Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C53672A0
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584957; cv=none; b=Ko2tRmhXyFouL9swaAidi4b3Gej07E0dsSOHD3BmwigZgSLCzejCMawYOYgv5s8pG/kGoRA30l4RhMZXy5TqlAQYQze1LxUCp3Ucm231Vv0RW+wS552kphv7kfcgtEiljv3quvLSNGzL6H/8NYn1icdme88uEduLYot+IIOf4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584957; c=relaxed/simple;
	bh=M7VHakZhxvIpK/CUFbYmyfBgA/y0vAlwhUUHkyKNhYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdvfp9m9uX8uEC3jwH4HBVZoMYhaPLpGRCI3QDcbtNz11CCqbsh0yMN3WcRwvQuHu/d0Z3gaAdE5Gp9OEKpXaHy2Rf4vXkVwgrwkN6XpYmEWe7DVyJcLyNbA6iWtsYgy0Dx/gIaAqTSM+0yJE6Vi6Omk1HxLBpraqxakHfyTv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MW/GyNL0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=guBlAW7f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW/GyNL0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="guBlAW7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=He6RFHl6rq/FSWjt0HcY9MKwV1uNr7NSbctKQDp7TZo=;
	b=MW/GyNL0BCUbO9s8h5DZRO525c7oEv8qpvqeEUUejpk57p+O8Vk/ju4V4KL3wgAoS+sJZg
	dIovVGNr1OOolpRlFbxaniDQ8F48qpYQFfQCfp3GuSp63/+vM2hDSnKvPJ7//ECaqsQWPk
	zivuQwFIeRK4I52/ivuVt2T7WBu/eW0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-iAsTQLHBMVSGC5kYtz9XKg-1; Mon, 24 Aug 2026 11:22:34 -0400
X-MC-Unique: iAsTQLHBMVSGC5kYtz9XKg-1
X-Mimecast-MFC-AGG-ID: iAsTQLHBMVSGC5kYtz9XKg_1787584954
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e9489f62bfso43028526d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787584954; x=1788189754; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=He6RFHl6rq/FSWjt0HcY9MKwV1uNr7NSbctKQDp7TZo=;
        b=guBlAW7f6lRdRFuf1Tkxlg4hQNZFuxbxDwd5E8owCp5K/Irke+ivRvzPO9Q2GPhqQS
         JmKrZMRNMkrKRDOyl6JOUgC9NpVaM06bmx8o/lQn9vnmas6sCnXQ923fRSoD7lgaSEDT
         KwyorJrmM7qlANsZNTGX4p2zR52WUWb8zKm/aEQnOp0tao+bgMp1Av+EZH0U3w4Uesn/
         Lp9ik0bkDJsP+v46GXSewmQvZ172r9RVP4baYrSHQoHaSpJWWshXNKs3Cd20cuw+Vle3
         5IQlbc6INuMwTeZAPmHcsl8ncJJ9YR4SHemVx5mY6gk0GQJGStEu4lz0Q0oLEq1tkEJg
         ovZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584954; x=1788189754;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=He6RFHl6rq/FSWjt0HcY9MKwV1uNr7NSbctKQDp7TZo=;
        b=gzZuqGoBxzSv6PaznNPb0/N1PWY64JS7sB4uS7ZRRr/HS66zBgsMSoAzh7ObR1+geb
         6KEUiN0Y9SWw9MwH3arBYzx1RNuRDd7H/mvuxOdn0lmLowTIoxW/kvlEr/a0j2XdPAI+
         0RNHCIdfUqg7qjp1l5E57e1SDMPUm2UzQv0/XNTyCOrx3kRcM7Hn/rFJqhiY+MlLLhLH
         kTuuW3PLhZb0rZ/a8/xbZAUCvxeXgJ82z4PrlsrbsJUwiCHa2tSuuj/Y37qu4WKJzvI1
         8Lu9mTNAooqllGekLbl1xIiSmNiqHjRlAiAOT81jY4o1ABsKDIDQwazzuoeISbaCSyen
         BRQA==
X-Forwarded-Encrypted: i=1; AHgh+RqSM2OTxnQK7tCr6Rgo8NueerfL+L2kMtBQGG+kutU5aCdJ4v1HF86xq1Ouuh7R7I9Y8XS6iy/GrBk=@vger.kernel.org
X-Gm-Message-State: AFuF++mLxysA8p3MYsG0ueh05DFWJG9pm3JUqxMhS+eqVtFuUB3lE0PM
	AAT5KxExtw3E2wyx4vDrjIqje4FEHI14ZnplqEo09TxRFZlGzRisSXvv/v41WMGEO4smSEhgdBx
	8JAnF5Z52jkzd9WQK4Q8L1D4ABBlK3pzxYC0gkOUmOuyILi3607AmjQL61camKA==
X-Gm-Gg: AR+sD12PA7/HVtbqNTz1tLgjW4b+HEz1Nz+s6LtQ3F2QFSyfPDvtJlLjfm8AcqfmC6Q
	LADcvWZC8v4ewYi3SrNT3qJW/h9s/12LNxobaVh9ND46OwBGgwYLdVGGjnrDPjgqog3EqVUTKB8
	KRRbO3bRZoFo8ELWuRvY6dAO9g2QHjZpVKCbJUCf8nFZreMdIeaMRJrILAYLYY6BDMjfqpVpEJ7
	YLW2N0fKyQnUYejjuj4Xg4Ipdlj72f4f2oHTPX9dpE4puJ2SzjXHRD9qXiM0YJ6woV8ycs07OV5
	BqBl161iMUpoIBnJw8aibiHrpcZZIbiidGkpf7UnQydqPr4BhZDG0Y4YPbjy7BFXX+UuRef6yrQ
	pG/ubKimk/hGe2NokJqHyV8/I8v7Sy2l5YDM=
X-Received: by 2002:ad4:5c89:0:b0:908:3e1c:647f with SMTP id 6a1803df08f44-90c8fa9093emr222737286d6.32.1787584953861;
        Mon, 24 Aug 2026 08:22:33 -0700 (PDT)
X-Received: by 2002:ad4:5c89:0:b0:908:3e1c:647f with SMTP id 6a1803df08f44-90c8fa9093emr222736316d6.32.1787584953292;
        Mon, 24 Aug 2026 08:22:33 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93619bbcsm64952496d6.20.2026.08.24.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:22:32 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:22:31 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: meson-gx: FIXME: Make sure clk_init_data is
 fully initialized
Message-ID: <aoxhtzBk0SH7D8hQ@redhat.com>
References: <cover.1787240090.git.geert+renesas@glider.be>
 <4b9a377a810b69a4eb885fc00cb34ef63e7fc1f1.1787240090.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9a377a810b69a4eb885fc00cb34ef63e7fc1f1.1787240090.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Fri, Aug 21, 2026 at 12:06:03PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

It looks like the FIXME should be dropped in the commit title? With that
dropped:

Reviewed-by: Brian Masney <bmasney@redhat.com>

