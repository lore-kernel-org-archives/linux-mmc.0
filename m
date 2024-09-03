Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC21A4E88
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358459; cv=none; b=R2rQp2qQvlktUYMtTqqhGYxlcuMTR7p/jDcOE00uLYb9F6WDQJG4ct0CfW817ZfWgGepJ/FYp8Ml7Wvlx9ozuShAj3sWmYyDB7wdyegD409FIM3zNWoO3P8G9WkflvkOdrYE3K40oZs2KDni3otymzRzWEMQIYcF6l+xQZeYWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358459; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5BmBDVYUGiEoR+fMBSRyeowY/YaVUTk70FuWU8JIVmH/f6sE+MWAvr4lBeWNSxoZquv85Fmb3MfvvjGGtzXs+6aRsHfe9vhW+Yolk7gGInMHXCQpaywt4k3kfRuJV/KfViFH1eTuRHApVZkCn6iTFiCRrCWQXDy3uYAar4r3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=iXtT+R7Z; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="iXtT+R7Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=iXtT+R7ZwBI3jYV5vUu4iJGf5r
	GRizZsdA5PZxVwof13YaQ2n+EjOwtrfXgEfB3p+Dad2KtfGTJg9ORfkVAZztgc3e2NnmkuaQLDIsM
	B5DdHrlqa/fHd6yq1lTT5VdU8B9yQJeu3pY12FSiI+6TFxduws0ENtqqvai4bhNmeAA5P62rEEjmP
	TFmxauyBW9MYtZX38hpv3PpvvKMvm9MX5q35l/KLVCR30zmNDiJwihp2TCvA3lWezGg4FOW8wnwDG
	yRbTe9gsfy8VBL4RmF6oLD5KxBQv3AtjROivKunAHxR4DcoM8q1gpaNT3c3BmGjrgN5NfCxTTmzAo
	f3dCtkgg==;
Received: from [162.244.210.121] (port=49412)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1slQXJ-00022A-08
	for linux-mmc@vger.kernel.org; Tue, 03 Sep 2024 05:13:21 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: linux-mmc@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 3 Sep 2024 03:14:15 -0700
Message-ID: <20240903031415.4673C60F7C0D87B3@basantfashion.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080
