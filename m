Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EE1A08AB;
	Mon, 14 Apr 2025 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671444; cv=none; b=XiLLHOnkI4MJPFIUdZuz525G1RWws1mMmNTudVTbqgmXvL+GanzJafqBDv+epZOUEMM/9cc5o2JUXds884tOMPbe5J1epkBqBcf3mS60ECnURQfGsneXCH+SdeMRJc0cEHf9trQnLZFxA3p4Mh/Im80ZUPSou+RD7qG9p2xcqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671444; c=relaxed/simple;
	bh=MtcdSZqtQUUURH/jfI/BTfPSHmAN7P9iuFLz5NDWDes=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ldfJHlZ9qoBRZ3YLM1Jgd0TVCqqjcF6sehjV6f200IUpnEYtNeCksfWKhNEZ5duLPIKlf55WrJNRq7s55MwrECPNrNR9bRNMGyNOnTx0V9wHrrLBgeuYA80TI3LywRT/JcHJ3bygDiEOt0YDKQwB3HwoSUrO3YvIL1bTOk5Aq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MrJWG3N5; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MrJWG3N5"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMv0hD2882977
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 17:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744671420;
	bh=vtBt09o83mCgMJ6ZF1rrKa84G3+XGh4GoPhawkiEkYA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MrJWG3N53My+UI2lIxK4hHrqVtBmA8x7+rA46KB0b89pWBc4AB8SkwIC/X2BSIycW
	 dRWpNsJhIm7MVZi3bCu8zqplkGYdryEYSyzO4JfSqiqqZqL4xTDySHx4ZAkQtVV1jG
	 zpAqUG0Tb99ccGacCYvdeh89GfXcxYaQvgALm0Pc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMuxnT014874
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 17:56:59 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 17:57:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 17:57:00 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EMuxX7076324;
	Mon, 14 Apr 2025 17:56:59 -0500
Message-ID: <bc09c5b8-ce53-4d43-86af-16b17f214d5b@ti.com>
Date: Mon, 14 Apr 2025 17:56:59 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hiagofranco@gmail.com>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Josua Mayer
	<josua@solid-run.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Moteen Shah
	<m-shah@ti.com>,
        Hiago De Franco <hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
 <20250414065119.GA6309@francesco-nb>
 <65119d3a-6907-4911-ba19-e3bcdb65b529@ti.com>
 <20250414145712.GA59296@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250414145712.GA59296@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco,

On 4/14/25 9:57 AM, Francesco Dolcini wrote:
> On Mon, Apr 14, 2025 at 09:37:53AM -0500, Judith Mendez wrote:
>> Hi Francesco,
>>
>> On 4/14/25 1:51 AM, Francesco Dolcini wrote:
>>> Hello Judith
>>>
>>> On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
>>>> My understanding was that we do not like adding new DT properties if
>>>> we can find a way to apply the quirk in the driver.
>>> ...
>>>
>>>> If this implementation flies with the maintainers, then we can go back to DT
>>>> property implementation.
>>>
>>> Not sure if this is clear, but this patch is NOT working according to
>>> our tests, we would need to fix it in a different way.
>>
>> Not sure if you are following the thread with Hiago, but we are fixing
>> it a different way; add a new DT property: "ti,suppress-v1p8-ena" for SD
>> card which allows us to have granular control on when v1p8 is suppressed
>> for MMC1.
>>
>> With this method, we make sure the quirk is never applied to your board (;
> 
> My board needs the quirk ;-)
> It was not clear to me that this change was going to be added to this
> patch, because without it's not working.
> 
> Thanks for the clarification.


Understood, Ok seems like we are just waiting on Adrian or another MMC
maintainer to comment before sending v2 with Hiago's suggestion,
thanks.

~ Judith

