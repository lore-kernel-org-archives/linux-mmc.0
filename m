Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB7E55B;
	Tue,  8 Jul 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003069; cv=none; b=OrKATknaNZlA7f3/L7b87hjmFTt4kX667MxtOPW1Hx00v9MDQkDMVZm8P2ELPURcQ3bc15uSuz1Hae0xrInZxxD+0FhAeT8p3CsaIVXgUxOiwtlLHjT5WfzcMFiTBaj8dQFwnGGrJjjb/PYa+7YSGVD/xgR0hbjSz3/P9jejUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003069; c=relaxed/simple;
	bh=BqOK8MX/2bkxDW77bV+hqSHjpVcRKdgW74773rhjp7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG3E19n+roSgMV5KbchauWZE68BnglLNeM9ytLocuj7FvD1oT5cjtcYZUeHcuwDIfouK6KQsIVOByM91w7IfABO1e5A0TiSVP5imVTO1yezIvrfvNctNboI5dmo2W3NxNAhedXxTVUesZYzqIsHJEnTnfcTPQvdYkFbc8GAW/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1ijntGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1ijntGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7076BC4CEED;
	Tue,  8 Jul 2025 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003069;
	bh=BqOK8MX/2bkxDW77bV+hqSHjpVcRKdgW74773rhjp7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j1ijntGR4WATssYtHyzEAOTbtobujQQ2Js9iLxwlkcQtndfE+Ygl3FJBSrYbLvBvL
	 BrudquSVz4slvXBlboKvsVm4B03ZsBDrBDuQuQotYz6uRWjW3o7V+gRXuRE9YnLY51
	 SLT+YKcGisgtGPA4Of+AKIlMLmLlFH76Xg3MlWS8KUVZFhTaGtvtcgbmWWHI4tLXKG
	 rnH3A5d5YnLhDClJwwepmAASxe3VxwPOLaCN4qtXmxgOngJ3OHNk0bnGX/QlaM5hA7
	 qWzDdp4tZ0XHCyIM96WGYklp5TvKvvfwUf4nn2ZcW6lvUvO/lJQBoDkzOe65U/xUNb
	 uO7bC5JJoodHQ==
Message-ID: <676fbd97-8de5-49e1-b378-18f9c918a51b@kernel.org>
Date: Tue, 8 Jul 2025 21:31:05 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 7/8/25 8:37 PM, Lorenzo Stoakes wrote:
> The alloc implementation is a thin wrapper over slab/vmalloc, so to help

It's much more than that, as far as MM is concerned this is true (no need to
change this in the commit message).

> out on the mm side of things and to be cc'd on changes, add some mm people
> as reviewers.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks a lot for sending this patch, it is very welcome! I will apply it once I
have an ACK from Vlastimil, Liam and Uladzislau.

> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71599ab6bd56..54dd937160ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
>   
>   RUST [ALLOC]
>   M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Uladzislau Rezki <urezki@gmail.com>
>   L:	rust-for-linux@vger.kernel.org
>   S:	Maintained
>   T:	git https://github.com/Rust-for-Linux/linux.git alloc-next

