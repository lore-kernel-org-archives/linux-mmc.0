Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4661F8691;
	Tue, 10 Jun 2025 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530477; cv=none; b=sL+iP/pJZlzUlXn4U4Pdo1tZ9I7j6w9hwZjLIKG//Nbpk7G9jMRqOa8pVdY4ztA/NIssxdfM3heMVFaywj0ukf7CdoWmJgJpFC4OlCk4JOjsxWVHxwPB2g9E7zF1XAYXGxeLtrbFY4cvuzb7xcGEoFaxJGrPFLfabzD54EQeFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530477; c=relaxed/simple;
	bh=Pyjffi+nSLucRE3vgdFGEa3GGlSbXak0lR4GOVC8Kpw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UbZOXfFgi9MewbIp6RBuZyuLQ4rR2pJMmyRWSKYbuqBn3uVQNncSEhbFj78Px23Ob9A8WI3YWK4WLvihzZso6C2w8lsmWJPAVBEJtMHkTYxRmED0/Q2ibHvzzKozzsg4zx0dIT1XbQBpYotdK8hqBKY0vIhEmX/LmprvKBVnm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVurc5Da; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVurc5Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B956FC4CEEF;
	Tue, 10 Jun 2025 04:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749530477;
	bh=Pyjffi+nSLucRE3vgdFGEa3GGlSbXak0lR4GOVC8Kpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVurc5Da7zoxb7qboPt7il++of/iF6QU4W6ngC9c9cH9Q5Zm3udHMWscCLozL/j85
	 4wE9GPCewfsBRWY/U8pBfIS6emzt4I4nEZexQ/2Vd25NweixBY+HWoI+KHnKthbius
	 F9yp8PG2S9bEFIJqz9zPveWqbADBzoqQUHwcsYoM1hngikMoB7HadHgeZzG311ss3m
	 MK+YscFAOvLeGWsJbdSkAyb0DurXCHjGwtcWfoi23LQFMXYgoCTKh8NvYrARwnLQmd
	 CT5BeuTSzCoPiYsd2NPwNo775+RP9ngcS9qRoKlrTJzmPVg3rLsfJGohBzUTO+NFH2
	 tyNkq39TThvvg==
Date: Tue, 10 Jun 2025 13:41:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtk-sd: Fix a pagefault in dma_unmap_sg() for not
 prepared data
Message-Id: <20250610134114.5ce2c929b683be6e4f228f2b@kernel.org>
In-Reply-To: <CAPDyKFrejbW1d+jSSJE4K8Zb08CeMHiH9pC=Sr=Y51Lyy4Fhow@mail.gmail.com>
References: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
	<CAPDyKFrejbW1d+jSSJE4K8Zb08CeMHiH9pC=Sr=Y51Lyy4Fhow@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 16:25:24 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Thu, 5 Jun 2025 at 03:07, Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > mtk-msdc driver causes a kernel crash after swiotlb buffer is full.
> >
> > ---
> > mtk-msdc 11240000.mmc: swiotlb buffer is full (sz: 16384 bytes), total 32768 (slots), used 32732 (slots)
> > mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=18 arg=0397A6F8; host->error=0x00000004
> > Unable to handle kernel paging request at virtual address ffffffffc0001fc0
> > ---
> >
> > When swiotlb buffer is full, the dma_map_sg() returns 0 to
> > msdc_prepare_data(), but it does not check it and sets the
> > MSDC_PREPARE_FLAG.
> >
> > swiotlb_tbl_map_single() /* prints "swiotlb buffer is full" */
> >   <-swiotlb_map()
> >     <-dma_direct_map_page()
> >       <-dma_direct_map_sg()
> >         <-__dma_map_sg_attrs()
> >           <-dma_map_sg_attrs()
> >             <-dma_map_sg()  /* returns 0 (pages mapped) */
> >               <-msdc_prepare_data()
> >
> > Then, the msdc_unprepare_data() checks MSDC_PREPARE_FLAG and calls
> > dma_unmap_sg() with unmapped pages. It causes a page fault.
> >
> > To fix this problem, Do not set MSDC_PREPARE_FLAG if dma_map_sg()
> > fails because this is not prepared.
> >
> > Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Applied for fixes and by adding a stable-tag, thanks!
> 
> Note that it looked like the patch was not entirely correctly
> formatted, but I fixed it up when applying. Please have a look at the
> fixes branch to make sure things look okay to you.

Thank for applying and fixing!

Thank you,

> 
> Kind regards
> Uffe
> 
> 
> 
> > ---
> >  drivers/mmc/host/mtk-sd.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 345ea91629e0..3594010bc229 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -827,9 +827,10 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
> >  static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
> >  {
> >         if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
> > -               data->host_cookie |= MSDC_PREPARE_FLAG;
> >                 data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
> >                                             mmc_get_dma_dir(data));
> > +               if (data->sg_count)
> > +                       data->host_cookie |= MSDC_PREPARE_FLAG;
> >         }
> >  }
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
