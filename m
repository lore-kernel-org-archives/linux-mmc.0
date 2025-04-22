Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4A35949
	for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334360; cv=none; b=uaSExmTUQark61qaUuIc5AmXTnL9T7N7oWcRCN74vOHon9FkI7J2roVwCiErCe91FTFbqGfZvtS4MeYnHRRp3CMYaeEBgEoozR2BejTWbwiiM6t2oegT+rVBDNMVYpjL0RuWlPpg3ztLoKKl4gSEYLqpfSM4FiXDkLoKbiUcmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334360; c=relaxed/simple;
	bh=6z7oESbSQ2gmPy7O7QfEiALKoD0L+CFnW7p2yxI3ItA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4e6ji7maMC7A1jHWth7pHagpL7O6NUqGClrBBvZBEjt1SE7ACLuy/qPNWg6+r8/PNnKEDTeBUHDV5hP1BGWuxHrNR/4Av3D9LkciFCR9JODEw+pBy7wLpWDEnmAI26nzEf4aJRBSgj5THGOBhFRqtzcuhqvTaMz6HEgDEWa6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrFVml8c; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrFVml8c"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70814384238so6191157b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745334357; x=1745939157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nsiipJoGMYNCoOADOij/s40x5PnBvSLcT23bpWpniE=;
        b=nrFVml8cxNCt/EQ42M0rpmBeRieWjxWU/PafmuBzhDBqItkEMZSzyAWhdJtFoUVxUw
         RybHd6WnaD+tnX6NswnCZddrlNTwGvZkPCPj3yh9djEJvLISW+DBkrNDivK+u0SIDWZJ
         vQ5ZdMhZv/FYjXxo4AjCc7hJL8X5ssW7Ce2ZM9jZEk/h15K9uOXphmbI6T57mZUVmFD1
         XL7VusCZv/dzZbTr7DdsAOn8WA9jnH034x2IBRltunITQTbCDSYjno2wIB5JVNtV7Y9G
         HeWPfhW7eZNboWbZcnuVLSZl50PO0vbugD5KIxky+vyX0+obMQhg5JVonNi+SFyzHdlm
         3Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334357; x=1745939157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nsiipJoGMYNCoOADOij/s40x5PnBvSLcT23bpWpniE=;
        b=Q++q/WuhLSgOXVvgB6CH6U5o+kpY0cDvBL8b5gr+Rf7/Vhb3mJswaQGI5cpvk4v63T
         uroGpP12wwz8NZ6/lqS/aNL3f6K2he/lITqD55FMX0CK0kK0ZPW+WnIZ0ZXNjKj25/tH
         DjWvZzIc0uHJsPLKFt8q83MgnosrOj6TJsyM7V22P2CfD19IRsFlIolNNuaofYqbdrHv
         2ve9DHDSp52BdHeZ3qLSsFVny+yTVCO9X2SlFrtpcL1HLejI8z7avrQIyI2bea1X96gR
         zbe4BiaxDhpJ38hMcQZAvCjE7MrqSc8cBqTVa/OgmBJNjqk1K5oEjKw/xCwsIAlpCIqU
         ICNw==
X-Gm-Message-State: AOJu0YwAme9tFI029SpiPBLSaGp2ESpKKa1lgdl+6utgsYdaWTuSeqh3
	8b7SS5GzJvKalLCBU1YtfGzMcc0LgX3Nqst6cWgrfZGrfq9vI90JqItOdbZZ0y34srrrYcgShFg
	CsGgIMXKTEN/fH4iWYp8aItHhdVZGcq8rbb5AZ4fVLQCH+sjj
X-Gm-Gg: ASbGnctjw3zrYciNMq8nOv0Q+L6A2DLBfFRl8GSjY0/oVech4KAoyZd2q8sGw4Jhdx1
	BKvXvWwXeLgBfDrl1Eif548k0DVGbQQmWyZ/y9eqdJoIiN5uXWb0079IhelLSLNha/ds+YU1cjX
	jp0/9MgkjPQpxfkQR+9NwRJ90=
X-Google-Smtp-Source: AGHT+IH2dkaFPFc/TfGTvvZftMs4vMQHmsaclKgtsV0rKvWkTqkF/nZX6QGxb2LRTj+71aC99gwfbBwFKxUPMYBpv+k=
X-Received: by 2002:a05:690c:4a09:b0:702:72e3:1cb6 with SMTP id
 00721157ae682-706cce259a1mr214973167b3.26.1745334356653; Tue, 22 Apr 2025
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407082833.108616-1-avri.altman@sandisk.com>
In-Reply-To: <20250407082833.108616-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Apr 2025 17:05:19 +0200
X-Gm-Features: ATxdqUE6QSYr5SA7jwMi4LaZR7jhzWnBE5qBuANqxhSewaO8Cof5Srr5NRMD6EU
Message-ID: <CAPDyKFpyQgsQV8mGOs65f9fdG7DOorZ+zrpKTWr4B4U8ztNDpQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] mmc-utils: Secure Write Protect Mode Enhancements
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 10:33, Avri Altman <avri.altman@sandisk.com> wrote:
>
> This patch series introduces secure write protect mode functionality.
> The first six patches are cleanups, while the last four patches add
> support for various aspects of secure write protect mode.
>
> It essentially adds the last 2 missing RPMB operations: Authenticated
> Device Configuration read and write requests.
>
>
> Avri Altman (10):
>   mmc-utils: Initialize RPMB frame_out structures to zero
>   mmc-utils: Reduce scope of nargs for RPMB commands
>   mmc-utils: Pack rpmb_frame structure to avoid padding bytes
>   mmc-utils: Add byte offset comments to rpmb_frame structure
>   mmc-utils: Add SECURE_WP_INFO field in ext_csd register
>   mmc-utils: Refactor RPMB key handling into a separate function
>   mmc-utils: Add secure write-protect mode enable/disable
>   mmc-utils: Enable/Disable write protect
>   mmc-utils: Secure Write Protect Mode Read
>   mmc-utils: Doc: new secure write protect commands
>
>  docs/HOWTO.rst |  14 ++
>  mmc.1          |  39 +++++
>  mmc.c          |  62 +++++++-
>  mmc.h          |   1 +
>  mmc_cmds.c     | 379 ++++++++++++++++++++++++++++++++++++-------------
>  mmc_cmds.h     |   5 +
>  6 files changed, 398 insertions(+), 102 deletions(-)
>
> --
> 2.25.1
>

Applied for mmc-utils master, thanks!

Kind regards
Uffe
