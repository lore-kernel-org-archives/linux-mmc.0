Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED8187874
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361898; cv=none; b=foWD5gyhzt6v5i5blcgO1zf6b4aAWtj2DHeh3rOTRvyl6GEhuORj6n9+cdWruHyAdQY9E7bwU/conOodfgibJAft33ORAWnHrmX4irFeuYuQxVDdXudYei/ymlb3Yyad4RHXXbT0ltGWl0niLUuIQ2p9647x5xRIpz62O0jxnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361898; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJLhosiv4tY/ux7ccs00VMDrTOpbuKu+gDEq9thIJiujCzJwzG5bC4H0qYyBYftcmoY3N6ZCCtZBguSm8PYGY9PSSuX820sNFmSxzHd67zjMaxXcMVUJiPBEMkBSNXcjKKWQQ9w7is+QrzfQ73LNMmiiIRMJPmZBxVK97wVUwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=CQRVDrQ1; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="CQRVDrQ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=CQRVDrQ17R6Lu7W7fNr/3Lsluw
	mNql/HihjpsJrOXxXksqDlDntKImDiNyAr54Mf99q1Gd1RGjhfKHP57nALjLB1SGjDp/4BTruwPzQ
	NHbNOuCu0SvDaihuZibHVIPOw/TpYsw1qOPzbldycVRt56AUKlwTv0E4A+9At58NhGOKrO2dJ4g2T
	oBYFh6E3VqZ4nligalt2rJH4ei5MeSJfXt4fTMy+w5g6NaoqmswTwhhtRpKDlT+y9WjOa4u8Pmw1c
	tql1LBw4Wm5gU9MYCG3inyo77IwQ9uBQ7vUCKFCu1HxPlpF7f9vPX2uFXp1LixZUYsDo3IjcM/kcA
	vJEvPd7A==;
Received: from [162.244.210.121] (port=50055)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1slRQl-00033A-Th
	for linux-mmc@vger.kernel.org; Tue, 03 Sep 2024 06:10:40 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: linux-mmc@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 3 Sep 2024 04:11:34 -0700
Message-ID: <20240903041134.CC6D5F5DAD1646E0@basantfashion.com>
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
