Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8261607A4;
	Fri,  7 Mar 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369954; cv=none; b=uoHQCP5xslTid7Z5r3yZBCHpgU4OU/yvNABYZ/E3qZLpVwzehs4wIqbjgrufnGB/cE8MQhL6Ob8umv6NLNr4GqEFy5L6kYS9dHEM/iLuojev6Gp5tCmpmJxlyKt9+4CKs0iAfCqiJJKjeH9WdRGm1HV8dk1vE2QPpLQF5Blm9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369954; c=relaxed/simple;
	bh=gyQ1ht+J8DmRAR7Prqe5gFNunJgb4BZkKTGfC87pY4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPOKNahtmKLfMDk8NSIl4ytEd9RdGFZa+8m/ic5Q8TuX43Pbhud9HeCsIibiE+MTTdn3x3iyriPDMFw6ihIumSh1ar52ZOE9e/IEz3WpUfahLeaP3FY4quLab+7YgQvyMMiKL5NLAvgI/fdj5NwwNWESjitpTcoKN9H7LW61MH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=myQME7X6; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="myQME7X6"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EgwLQ027680;
	Fri, 7 Mar 2025 17:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=1MNzwNl1V5MdHjo8Dhdn0wtzHYZEu9JeuucxhO/f4Vk=; b=myQME7X6f92r
	cDkhPKE4u7WaLln/T8B1LMvFPm4Af85VWMwbO4qiOBkdiDqypPsXP4LHXUJKwnQn
	BLQuTx9ZVqC1I27vbjuT6tlTxvFcC1gywv2VerM1sneRHF4fACBsI4Fthk/VLbzZ
	+yjjq5uZKd49m/MiQOqSJ/Mb0jteJ51LGWa5y2NOWfDulMom7F2pteW6UsHKWolt
	ERWjdmeBAGRckk2E6F6iKpUDYrqN2cS6Z7qEZPB0rBght7vBUWKEvEhL6QbH2bA/
	2YHjcilztqofZIOioskZWn0qWx1Ip2o9sPQJOJQlXwIiOhWxbeFkKfi8RGhVb6SZ
	THX5kSWHhQ==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 457ypjwvbu-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:46:58 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:46:43 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:46:43 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>,
        <gratian.crisan@emerson.com>, <kyle.roeschley@ni.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Fri, 7 Mar 2025 11:46:43 -0600
Message-ID: <20250307174643.1288695-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <35aebb39-ae2e-4186-8de4-6830ec661f4d@intel.com>
References: <35aebb39-ae2e-4186-8de4-6830ec661f4d@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: w-lqO7O6jOSeEY0moDe-aW-5iOPqhre9
X-Proofpoint-ORIG-GUID: w-lqO7O6jOSeEY0moDe-aW-5iOPqhre9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=629 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070133

>> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be=0D
>> lowered to less than 0.5V for a minimum of 1 ms when powering off a=0D
>> card. Increase our wait to 15 ms so that voltage has time to drain down=
=0D
>> to 0.5V.=0D
=0D
> mmc_power_off() has a delay.  So does mmc_power_cycle()=0D
=0D
> Why does this need to be in sdhci?  Are you experiencing an=0D
> issue?=0D
=0D
Thank you for taking a look at this. The initial change was made in=0D
mmc_power_off() due to an issue we had with some of our devices=0D
requiring more time for the Vdd to drain below 0.5V. Ulf gave us this=0D
feedback on that change:=0D
=0D
> No, this isn't the proper place of adding more "magic" delays.=0D
=0D
> Instead, make sure the related ->set_ios() callback in the mmc host=0D
> driver deals with this instead. In case it uses an external regulator,=0D
> via the regulator API, then this is something that should be=0D
> controlled with the definition of the regulator.=0D
=0D
Should we take a different approach here? =0D
=0D
Regards=0D
Erick=
