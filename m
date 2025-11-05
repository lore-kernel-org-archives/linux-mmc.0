Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4C258CD0;
	Wed,  5 Nov 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357206; cv=none; b=NWzsrmNygSy+xDPek9Ifj8Xaj0qtTq7Tj39WzAg3vUL27+ukJ6Dsq5lHi4jOzXCONe8dFP9mHcpoJ1mjtWlkXdbrbMmyR8EgLHRNEJaK2b7YAFl5PqBEi3ApgfEmRsJAYsnocdJSmddbr6ljX/PtlDUZjpYVQHlrP247JgBWgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357206; c=relaxed/simple;
	bh=0AdgQPQBQ5614CjYT/8ghpUX8jPll4myC0xvjOQOOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgCKCcYjMXtdzrqvrDcA2+9VUV3mMSN708bGhCIXwjGF/RbJA+YbENVj0tt2DqG9Iab4sAJ+S0oNvIAyVuvw43RNbdjkCxUMDI+S/ARELS7V2LDP/p5QeBPNXCxWQBMb1YbUTTdlsV0saDPv0/qyK2cujWzupGVhiuGlIW0UhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZD++iarP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZD++iarP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762357202;
	bh=0AdgQPQBQ5614CjYT/8ghpUX8jPll4myC0xvjOQOOok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZD++iarPdfmEmGSj1omdR9WANjbaw5AzqcYKP1gVT99Qw7B/ERi9BaJj9ivLOCLiH
	 JLTrxj8wlLOijYKCLwMjkHb95chWXF+dLFvkZZTYGYpvu3aa74O/Bo5565hwwGRWQ0
	 XcqgU4TmipCfL3kpWPfl8Mn6E/JsyF3DGw4FDxH4HHDieKNHu+lGPnpmnDph1ZeAr2
	 WQr+SXIqgEctCtfbbbV47mGMpk3kY5dkB0j02h4PCFRiLg2uy64+WkrZ9vfOuIWLv5
	 QR8EnGKyugu1G2rGlbak9+E/zwb+p9MCOs1/9DqKvuOfzUvygp+qGhue6VCwu3vjQE
	 DwofNsOWqt4Pg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B1FA17E1091;
	Wed,  5 Nov 2025 16:40:02 +0100 (CET)
Message-ID: <9fbec168-295a-4278-93f4-e27a419c892f@collabora.com>
Date: Wed, 5 Nov 2025 16:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20251105145824.239054-1-marco.crivellari@suse.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251105145824.239054-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/25 15:58, Marco Crivellari ha scritto:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This patch continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Replace system_wq with system_percpu_wq, keeping the same old behavior.
> The old wq (system_wq) will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

