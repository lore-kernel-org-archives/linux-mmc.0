Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC481327E5
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441455; cv=none; b=id4YDQ/2YZ+uKX0jO8KAdZpksVMarWn+NfAXXfH9BdZuAPXQKEmA6CfhKNcwHYaV7iKuY8LQUpduUhu4w/sJCldFku5hdEmRcqWmhXSFbNL1Nr2Eq44XphIjM7ro9O1+8/Xjo8uIrpLmO5eSaKZ5p35rc2137XwjwUzdVPmvo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441455; c=relaxed/simple;
	bh=Vkl1EHmea5RS2QdkrJbp/SFmAdNKBQVJiON3LsXFshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlK5Us2Z99jOMcPimrPLLseU+RbBnzKJPutYtigODLUKs6FHePtA3IqQIG2wDFSEtgpFxlmvFTKrRv4zW/6eyFAvJjLvzz3NdN7M6ZrCnA73Pv/S9jLwtGUCcLBUWJsdJybBip49/erX60cgb2aGsJUbXSx0bwR+XoEO79wcNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZlZ8zQN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZlZ8zQN"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so3681914276.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441453; x=1721046253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXg8eh64uf6kAy1q86MyOl/wWX8HPYF03qXy9bETZTo=;
        b=XZlZ8zQNy4aKelKt70KiPnPpetXlbd/rK1siWAZfwIjMp8ndeZ/S0njFzNfTH+Nv1q
         Sxi61zzJkXnF9FqTqE8mEaMgnDp3SucS8e1M8hlcFCZXBQgEccqc6+RvZl50PDivW5D/
         lErlh+1CpqAnSY3nuM349Q2hLgF7m0IzvK6tKty6PXEbnzt0Ggi8nOQIkfhBQlTjhwTo
         NdBXqZXPBmqnL+bXZz2IexvW7VG7VMLpMS4AGfhWVSaBBHZd5Qoqiz5cU0ve4txQ6VHt
         VLYzMhrfLByMCTZ3pEkBeaBuDqpEb11GMbBH8LaGK9blDgEQNMQfOzJ27IgabAAvxRu3
         nryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441453; x=1721046253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXg8eh64uf6kAy1q86MyOl/wWX8HPYF03qXy9bETZTo=;
        b=YBXQp+gQvC5tDR/MIVvXJsQiyoOWNMmoK1ImFM48FnvyLoJAirelFptIrWcMX4UFtz
         KUQP4doKpMfF0xzpNgDzlGo54wPAGiJt82op2A+QILicgMBRlGjAyLbN7xeJ3Dpo7AC3
         uhBoQYC7OlvfQkJiiu3RaywjHAn4jaeghaEPmW2qDvy7vLnMpOGbCf/aGZNLJSLYcYR/
         BPbW9O7dVUW8+GGTpE4W24WROqWJROweNE6J9P3raUrMzxKz1LUcPrudrv+YFTsriWVd
         I6Y5Gh1EHJR+d49z+0uGwVXBAE4KaXHJ5MdrHXyra/5cxI5u2dwayhqz6bQtWdQXJ15R
         E4Tg==
X-Gm-Message-State: AOJu0YwqEtzwK8bsCd/YaJsprRDIk4Kqao3imIOnveXJpHoeoFeAF/J9
	bTHNYS1JNo/dWt7uGBYq5N8WGHlxFL6SOAwfwoAxeud2r5xPvpoYDp+hWtpIjjlxzFhI/BQ08xY
	Dbex8llsGiQa5lUP6hNz0kb7IO9fouV0Gw0R2OQ==
X-Google-Smtp-Source: AGHT+IHNenO+kRbaJrsPjMfbVhmg3vzOZVLAgmEWUWKF6qEPSTxLkqq1j6u/2Iz0IN8b+zvREABYCJatIUV9CSibqBA=
X-Received: by 2002:a25:361b:0:b0:e03:5b1c:e049 with SMTP id
 3f1490d57ef6-e03c1a1e3c5mr11974036276.65.1720441452836; Mon, 08 Jul 2024
 05:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624112542.25657-1-avri.altman@wdc.com>
In-Reply-To: <20240624112542.25657-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:23:37 +0200
Message-ID: <CAPDyKFqbWx9QWGe=6Arue-5ULFnna155GCLp9z69wmTgMsxOyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc-utils: Elaborate Documentation
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 13:25, Avri Altman <avri.altman@wdc.com> wrote:
>
> Here is an elaboration of documentations to pair up with the recent
> addition of mmc-utils man page. It adds a public page:
> https://mmc-utils.readthedocs.io/en/latest/.
>
> Shamefully, I recently became aware that Marcus Folkesson already added
> a man page quite some time ago, so this time I double-checked that
> Read-the-Docs doesn't already have a mmc-utils page.
>
> One thing that can greatly improve this page is an "examples" section.
> A good practice would be for field application and validation engineers
> that uses the tool daily to share their use-cases and practice.
>
> Keeping the documentation page updated, I created a github repo to
> mirror mmc-utils official repo and can be imported and re-built -
> https://github.com/avri-altman-wdc/mmc-utils.
>
> Avri Altman (2):
>   mmc-utils: Add documentation section
>   mmc-utils: Add Read-the-Docs configuration
>
>  .gitignore            |  1 +
>  .readthedocs.yaml     | 17 ++++++++++
>  Makefile              |  5 +++
>  README                |  6 +++-
>  docs/HOWTO.rst        | 67 ++++++++++++++++++++++++++++++++++++++
>  docs/Makefile         | 20 ++++++++++++
>  docs/README.rst       | 76 +++++++++++++++++++++++++++++++++++++++++++
>  docs/conf.py          | 53 ++++++++++++++++++++++++++++++
>  docs/index.rst        | 17 ++++++++++
>  docs/requirements.txt |  2 ++
>  10 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 .readthedocs.yaml
>  create mode 100644 docs/HOWTO.rst
>  create mode 100644 docs/Makefile
>  create mode 100644 docs/README.rst
>  create mode 100644 docs/conf.py
>  create mode 100644 docs/index.rst
>  create mode 100644 docs/requirements.txt
>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe
