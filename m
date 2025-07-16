Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A252F2C5A
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660549; cv=none; b=jbGMGn/wAiSW42qxWRAGzskwuoxt00V1hA0zWpXejZEW1ROtOcMSWf81YjlGg9yFpfaBHv8aby9DeAixuF/NC7HqwZiTucHXYdWI+ggRMACG60o5CrAyhSVoXNqbPOuh9Xz9Xec90mCL/PemFPSzZiBV4C2ON8vUr9R4ypearrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660549; c=relaxed/simple;
	bh=bFBhJZawVLHR8IcJ2Vcrd4R81/LwC9KrzFTtxMVX5cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M66ibd4gyN9TjMGXdlNoMzCq2nz/x0UJ8srb6g3rjRReWUecAhqEW31vOYwangvnHBYHa+svw6+S+MkLo4ekGM0mY+oUfAkJdZyGIJZVXBkAROTF1+HP30QoFnwyD2FMUinBrh+JrwzPqA7/pFW6AR8f584oY/p7ZlbjLeq9fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sN1u+dUz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sN1u+dUz"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7183d264e55so2774387b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660546; x=1753265346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gV45BWglfzhUxE59Qv4ombDQhK6ciqBH4GljP84GFs=;
        b=sN1u+dUzft03wayk/ercLDN00LqfpmYkT5JASpWQV9cKGOzp4Fj/BfP4suoPLQGtlE
         w/v4eWRukRI75cLmQD7SjCkvSN43rhA7nHRd1OKo5lUdlC9ubwecYGqMQUcMdkOm11Qh
         wTOt+4KzkFNcmomKhA7vtXvttgUO/pfBq0Xy2E+c+63jLGu32KV86GJw2wKUVL7ROnhI
         66KDJtFphj9yKl+KiE0ahGEEwb0JCXIyk1TD077C1jXnZQ9/DSIV0bz1Q/bGXYpmKLdv
         SwkJRWOizAmsoL7t2mMJu8ZS2nVeKI12VSxurVU93WaNGBID5K326LyFn3M9dvxMIBKC
         SsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660546; x=1753265346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gV45BWglfzhUxE59Qv4ombDQhK6ciqBH4GljP84GFs=;
        b=sG3z+LeL69u0a70Xk7Nx+MgEvSpzcAeEQ6QnoTwTtLxRVOnduK4EAAzHivXg8OxT2e
         Py26rYN+SrQxu3nFtr3PCpZbxNsFk8Ai2TfdD46Gnzp/lWKINPEpV2joEzaJoBpwGXwa
         G17mHtNaIWfu960XJlv8eFC/fPddHb2pTsWj2AhJyTEq238jU49Id3IEfT2Mb6/fmAkS
         vobYGMtZKMMO7dF3Gd3BLxgCbGDgV50O+s+d+wlzNS9YGTh7ifMydL/9KAeK5g6P4O2X
         pYmCz+8ZshtbIS29iMTOJ+xmDepdN51aHLsefpuLEjE8MNveErhbPnb8qk3qBJQz9OEk
         tD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjVQy6XndPwmnuz8IvE+fs7KqqCyX3Z/TVc73vJndq1RoY4nJT35u1evvxu438ziAQai4MwDPZIWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0W+y3xj2H473beHIgS6OU3D6DVhjMoKsKM4YxUu2Nn9fmbVmi
	to3sBtutgReunqSMsAm/t4h4hombKIFfKLaHU3NsnYcCMahnYNqEZNGt4DJ4QnPpuOeSwa45vuZ
	NOPfC8WVG6TxGRrJa96DrldTtE0DWHTO7alznhkjasg==
X-Gm-Gg: ASbGncvW7nBbeCZiDeLglSvqV4R548dOtf3GKCN++RuAVOJOMzZREkAlXdMC60fDX/k
	13oLa8lxr79qlIrFa50E5kuRb1Ev1lLNk5D2HWhzZGaLBoi9/eoRD4eS21pFlkg8u9o7ggUjf/A
	6IwqyC1LpQpVXUkO3iua19ogZO0FIEhPKQaK/EQ9/K8HHyXcSNAKHywQcxTtTIUVjkbaheSkPbm
	pQD1J19
X-Google-Smtp-Source: AGHT+IHbf9uC6mvlDjLNF6dIc9S4dSQ+VNOZ0NRDgEmrKLk0gdoDzLQwF9jjwQJK77A/D6L0h1BM5w/vF4E9CMZ6E90=
X-Received: by 2002:a05:690c:730a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-7183517dc19mr38773327b3.35.1752660545599; Wed, 16 Jul 2025
 03:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-memstick-fix-uninit-const-pointer-v1-1-f6753829c27a@kernel.org>
In-Reply-To: <20250715-memstick-fix-uninit-const-pointer-v1-1-f6753829c27a@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:08:29 +0200
X-Gm-Features: Ac12FXyidmVqEt8vJA-TGBN58fq86rVrqsDtWU_9Q1n-pkGowaYzgUWF1QhgIVw
Message-ID: <CAPDyKFpb+_N_XbZrZ02QDFfgk0MNMWb=oJC4V10+s+CrDXdUQw@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 00:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang [1] points out that id_reg is uninitialized then
> passed to memstick_init_req() as a const pointer:
>
>   drivers/memstick/core/memstick.c:330:59: error: variable 'id_reg' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>     330 |                 memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
>         |                                                                         ^~~~~~
>
> Commit de182cc8e882 ("drivers/memstick/core/memstick.c: avoid -Wnonnull
> warning") intentionally passed this variable uninitialized to avoid an
> -Wnonnull warning from a NULL value that was previously there because
> id_reg is never read from the call to memstick_init_req() in
> h_memstick_read_dev_id(). Just zero initialize id_reg to avoid the
> warning, which is likely happening in the majority of builds using
> modern compilers that support '-ftrivial-auto-var-init=zero'.
>
> Cc: stable@vger.kernel.org
> Fixes: de182cc8e882 ("drivers/memstick/core/memstick.c: avoid -Wnonnull warning")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2105
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 043b9ec756ff..7f3f47db4c98 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -324,7 +324,7 @@ EXPORT_SYMBOL(memstick_init_req);
>  static int h_memstick_read_dev_id(struct memstick_dev *card,
>                                   struct memstick_request **mrq)
>  {
> -       struct ms_id_register id_reg;
> +       struct ms_id_register id_reg = {};
>
>         if (!(*mrq)) {
>                 memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
>
> ---
> base-commit: ff09b71bf9daeca4f21d6e5e449641c9fad75b53
> change-id: 20250715-memstick-fix-uninit-const-pointer-ed6f138bf40d
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
