Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00F2AEFE
	for <linux-mmc@vger.kernel.org>; Thu,  5 Jun 2025 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749086063; cv=none; b=TTuitScC8R4A+9m8p4QssehgmgRXf1dyzMl309xWbbiJqwJZYddPBMbF1tDcC1Fdy9VtIFq33wpZYgy3DaNvBnWm0UzC3nZoBQoGiciPkChALikmHcEC3KHA9ygL/Ct14sIW3YrSS2jToANrK/VR3vtOFeZfPpEToh5gLWOe9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749086063; c=relaxed/simple;
	bh=VpwSnO3TEovl9FwPBZch/PLoVkB6RcDLjgSlrPemoRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzrrGcOazoaC4K1gijMwTUTYDzwgeYVqJTNMDlbw3VxjkwlRk4z+v5P5YLYJ6EJaFCwVIjcbc6oPmSdIX524T3nu89eEX43GEwsElCz9Lf3l/b4hYtM7WD3QkTsf3Zbj0n1/FQpEOZLp/bddfuIFAA9DnADDwBAocaN14EGuvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Muli3IKF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Muli3IKF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e09f57ed4so14734175ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2025 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749086061; x=1749690861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xG0Wdkt+NUraD2HgOh+0AFsEQcpWyh1rmYJFEEo12N4=;
        b=Muli3IKFnhD8hkdrwrBYqX0ZeJfis73NNHv/PJz4AdA4aKVGrIcMvFOLOi7SkwpA2F
         upUgt5OOOTFJ9TlXddemnLZw7Qq73tI3JtqV3wuPEbOZ/B4doYR5ZdkHP/Tb0DImJO3S
         9wqMhjF/7qqJpl8++utcwHPTm1KwqHEs/Iu68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749086061; x=1749690861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG0Wdkt+NUraD2HgOh+0AFsEQcpWyh1rmYJFEEo12N4=;
        b=La8uTqqrQ7PnPFPv1eKCsq+IrHjJy1AfP9m2DK1NuoVhngitWEWtUIjT3iK38aspC3
         LVNqS7WysAsx2sn0sdHU0GtQBNV/gpXc0/Ulo9E61+XbECIeaKn1UeEpiGiyPTrMv4Xr
         HJISFutM3B7LAQxnyvvQUw5Zo/NvVdydsWDCQlhYOTRMKnOaZkx7U4d12O2xohiu5Wth
         HNitT/jtIQ/XNDXaiJHny8HlJ+6nPYLSUtppDlvi+Ue1xK1qkZOHytL9fbiXfBKNMHLO
         wnABQhcWJZ5M9BipLH+repUWdiPJ34S7snIJousPjOkmYZLfEQLTN4eTOBCcVQZthxo+
         RMdg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsTbwPSvfCs+0Nmnhk+BdIvATr+nZvQDKiubmKVfqlw46tJ2vTLsb5QeMJ/FXBuDuzyiZ2fwxV14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgQyU2iwytvgau5yTbsg+Ags4/aq5WaSSl9UJZWdhUWYgnvgH
	zZwXDwKSrhPHC8kEuXNzdNEno8AzCoD4IF4RxvITGnyKu1+QfnRQpE8xwZCvDaIyBA==
X-Gm-Gg: ASbGncvZKVRRmE76G8XMrxjUaGrBgk/ChXq0NpNfZ3I5xXJjPboE/Pj+aPayfizRECw
	fkyCPZmSew4+Ni0UhEExuWrN1zme/xP/qp1PLzkeW1SWL9YysWV6U2QFJtTm0w6u7TFhMm1SSu4
	J9SKY763rL0rYXsR84/HZyApm1tyy26KhnfQMo6CI2oS9Ap0yQ//KiIiFDQDHeHjnnTEnEZOtLR
	8ZBK7ONh4rSEWAT1Av1vADujGwXwwrobLOTnH/zfM++ZftRSLNpSIEgBXMFD2Lo/vNL//ZzBE7m
	szfK4UoL54aXm6mis1xYXg0WRDitPi0TK58eTGYV+vZ3EIvY1RTjYzB7T9JIX7EVzQ==
X-Google-Smtp-Source: AGHT+IGslAg+kZSR5r1KLQpvpTAyqVFFwVIFqW/069qKCAdAOWTjgfmHSrr73Y4oBWMXmc3qhryGWw==
X-Received: by 2002:a17:902:8f92:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-235f16b216dmr15063785ad.25.1749086061279;
        Wed, 04 Jun 2025 18:14:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:bc6e:7ca0:2017:eae9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd908dsm110307055ad.59.2025.06.04.18.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 18:14:20 -0700 (PDT)
Date: Thu, 5 Jun 2025 10:14:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtk-sd: Fix a pagefault in dma_unmap_sg() for not
 prepared data
Message-ID: <yf7ehbrvjj46xl7hkjukygnvy5z3ez43ewqch2mksx2lmkd5of@kthk42zpjabq>
References: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>

On (25/06/05 10:07), Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> mtk-msdc driver causes a kernel crash after swiotlb buffer is full.
> 
> ---
> mtk-msdc 11240000.mmc: swiotlb buffer is full (sz: 16384 bytes), total 32768 (slots), used 32732 (slots)
> mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=18 arg=0397A6F8; host->error=0x00000004
> Unable to handle kernel paging request at virtual address ffffffffc0001fc0
> ---
> 
> When swiotlb buffer is full, the dma_map_sg() returns 0 to
> msdc_prepare_data(), but it does not check it and sets the
> MSDC_PREPARE_FLAG.
> 
> swiotlb_tbl_map_single() /* prints "swiotlb buffer is full" */
>   <-swiotlb_map()
>     <-dma_direct_map_page()
>       <-dma_direct_map_sg()
>         <-__dma_map_sg_attrs()
>           <-dma_map_sg_attrs()
>             <-dma_map_sg()  /* returns 0 (pages mapped) */
>               <-msdc_prepare_data()
> 
> Then, the msdc_unprepare_data() checks MSDC_PREPARE_FLAG and calls
> dma_unmap_sg() with unmapped pages. It causes a page fault.
> 
> To fix this problem, Do not set MSDC_PREPARE_FLAG if dma_map_sg()
> fails because this is not prepared.
> 
> Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
