Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF96190477;
	Tue, 20 Aug 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165256; cv=none; b=vBoIrzJya9RVNyj5gqzur+j0flfIqt8IrDGpGWaCE1twF2kk5eFl+79X/BA/RYoHyzbyCAIo7k9VmafwisUNhBDQUM4tKFNmS/Z0DTiCTzOlykFJqiV4hyGnSh53+UYM7ja62DN6rt+Yuxgj09h2qPpNdc3m+xlvE53Td8rHToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165256; c=relaxed/simple;
	bh=RPfJlisKrzDoTGaoZ7uPi4f1TxcmpGkWqR5hGE0Dh/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pjn5e3r+YIJvGO7s2qE30khV0gtsXvjuuxyKj4i7nhEznMla/goZCNknKXqsFbKN5LIE81eYqNLOB2jJLgJ9tMJjJSx6kz1+fRIP85+Lwj/sxsWALSbmUPQNJBjE/mV+fx6cvDliJCknTwNCjAQWt8mZ/CwXaQBpTUBU7n5L/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eQD6BfpZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eQD6BfpZ"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KElW4W075704;
	Tue, 20 Aug 2024 09:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724165252;
	bh=RPfJlisKrzDoTGaoZ7uPi4f1TxcmpGkWqR5hGE0Dh/s=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=eQD6BfpZt+KX9//Gp2otjevlWnY2dONNZf6VJTluJwvmBhO/8JvxuKa9sPFjHFzH9
	 cdSKvflkxvGtPjt06cnWephPChQMxKMOxz9Ndqmouowy/FnWgFALXnj5A/O5Gy+IkJ
	 oyB1i5PhpcoDt3lX209ycYt13LCcCSt+jcOKnpr8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KElWTF081274
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 09:47:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 09:47:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 09:47:31 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KElVbD123118;
	Tue, 20 Aug 2024 09:47:31 -0500
Message-ID: <954ef458-7234-4d65-8315-526aab85fc1a@ti.com>
Date: Tue, 20 Aug 2024 09:47:31 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Add retry tuning
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240815201542.421653-1-jm@ti.com>
 <20240815201542.421653-2-jm@ti.com>
Content-Language: en-US
In-Reply-To: <20240815201542.421653-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 8/15/24 3:15 PM, Judith Mendez wrote:
> Add retry tuning up to 10 times if we fail to find
> a failing region or no passing itapdly. This is
> necessary since some eMMC's have been observed to never
> find a failing itapdly on the first couple of tuning
> iterations, but eventually do. It been observed that the
> tuning algorithm does not need to loop more than 10 times
> before finding a failing itapdly.

Will fix-up this commit message as well, there has only
been one case like this so far.

~ Judith

