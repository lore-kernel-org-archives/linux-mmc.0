Received: from mx.et1.uk (mx.et1.uk [116.203.106.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26E43C7A5
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.106.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910195; cv=none; b=csSW85CRVDYjEInz8UcataTO4cvQTz1E1IZNuxCxu4TD8uW8p5DphJL6sRrMOiuIL6q1TCciWWQc8wgBEA0mP+05AKor+iLjemUUTzENQk0eFyPOJYOyy+dmOnqxbLYwRBgPxa9CE8GurASBkc+Zw3mZZtX6PC84cJiUY458SAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910195; c=relaxed/simple;
	bh=hzVBusIg2mV4cIa8oAUVjvBBJTeh+BN7RYfmA5M3Utw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QttcAGXZmkLBciJdeGJwRSjt0a7TpxjLmIn3sZ1QQfyLDHlD3k//D7opAvPaiJtFOs6phJhMPYe3T04TTKvLWlGKx5r1LPa0b6RDTPoqrTITju0BRlKZ0yb6g5jQbQ2WuR/2QZmGcumfTGwh3NWzeDXf1cB/pawO4xzWovfDHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=et1.uk; spf=pass smtp.mailfrom=et1.uk; dkim=pass (2048-bit key) header.d=et1.uk header.i=@et1.uk header.b=bF3/+XXs; arc=none smtp.client-ip=116.203.106.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=et1.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=et1.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=et1.uk header.i=@et1.uk header.b="bF3/+XXs"
Message-ID: <44dba018-151a-4e9c-9f92-0d0cdce0b61e@et1.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=et1.uk; s=mail;
	t=1784910186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJsSj5K/tET91en1mgAeiHVmJ1YJxqjYsqI+yZqqXX8=;
	b=bF3/+XXsbuY4RbYfI5eNFK+JH6j37psfpZCTlzDtYWVW6YNRSCODca3HiT5RfhdcYXAFXF
	TEEK/Jb3mOFI3fVgMTRRphn0KpWrDWJCwT0y2gRW4tO+voEVC2hLlqDFGBM2F1GbJvoSxl
	E++lvr7AeK7j1u8pR6We3GokBYu61hlhV+vzGzzKnft97H2LXjYIHZz8jfnX+RK8I3uFRE
	hpotguLE2Jr3kDNoqafSvUUUlsDmDySStQmWOtBFXmARr0AHJEdZIpT6SprZ09HK5yJufn
	SeaADekvrYaeVs7DTwKGy8npP7tGrsDNM9AdvR8gYIrhssPGJ/7SHzw/170PqQ==
Date: Fri, 24 Jul 2026 17:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PROBLEM: mmc clock reduction error on NanoPi-R5S (rk3568)
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <43e06f45-7617-4a6c-9b4f-f952e8700456@et1.uk>
 <b01a6658-e575-42e6-9520-e8bb55d0329e@rock-chips.com>
Content-Language: en-US
From: Peter Taylor <me@et1.uk>
In-Reply-To: <b01a6658-e575-42e6-9520-e8bb55d0329e@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 22/07/2026 03:54, Shawn Lin wrote:
 > May I ask which dts file you're using now?

I was using the u-boot 2026.07 release

On 22/07/2026 03:54, Shawn Lin wrote:
 > The RK3566/RK3568 SoCs only claim to support HS200.

This was really helpful, as there are some custom u-boot overrides 
adding HS400
items for the board in its device tree.

Removing these fixes the issue. I will be sending a patch upstream to u-boot
shortly

Peter
