Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16F1C3D
	for <linux-mmc@vger.kernel.org>; Mon,  6 May 2024 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966600; cv=none; b=rsjJEO9Jq1WIs0AxcOhjDcQBOylpD179np77M1OKcfP/KHEJX/i2rSN+VtfH2deMXisztxdB6cczi0vvaasGKZp08vxAYXhl/Pf7NEgT5hjw758rO4nOZy3s00e41eLFDAjWDRuF/8PafXlx2jpD4eN/f+/31/luKx4O8he97W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966600; c=relaxed/simple;
	bh=ztfxhd4A3th54sopzAGP6X6xERr4UYOINObFo/JorQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dppGubo6EIEMjJTvtL7Wm3sQsEQ5u3Cuq3EcIaHJFFHKW8R7hq+kcD07CV4JAbunqHBIuRlTZkhgAENMs2zY7XF3cwDQ0D/mhlYa1e+2xHEDzFKTKsIZ4KiP583SAx/SVpIS7ncsG1WzcAIZ3WxHX3LUHOQAKwl+5P/9nfqZCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZcWaNa2a; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZcWaNa2a"
X-UUID: d086790c0b5911efb92737409a0e9459-20240506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OTz94m0ChgYvoExc1q4KYKJnwUNajfLxlZy+6zJmul4=;
	b=ZcWaNa2aWw7mSZka15woZwHKNsK0r1gyqkd4xDQLzAv56CM3dW7B3biShpiy+xyFcblX3OBeEuBeVRUdUTizgVyCO06js8hBg1dzxpdgTvo+abYsBFiwVqAT5fplZqUbR+xn/MH8CGQREs8yAR7USbotwhGBZOqW+4HILmU/V4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:751b2da1-722d-4abd-aae5-e8e1f3ff03f4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:67d2b8fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d086790c0b5911efb92737409a0e9459-20240506
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <joe.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1862192973; Mon, 06 May 2024 11:36:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 May 2024 11:36:20 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 May 2024 11:36:20 +0800
From: Joe.Zhou <Joe.Zhou@mediatek.com>
To: <ulf.hansson@linaro.org>
CC: <Joe.Zhou@mediatek.com>, <Peng.Zhou@mediatek.com>,
	<Sharp.Xia@mediatek.com>, <Sophie.Wang@mediatek.com>,
	<Wey.Zhang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-mmc@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] mmc: race condition between "sdcard hot plug out" and "system reboot"
Date: Mon, 6 May 2024 11:36:44 +0800
Message-ID: <20240506033644.10538-1-Joe.Zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAPDyKFoB+r7KMdbV-svz9d=WdPm1Zvd6oZppzbsPDWqX7YN_Kw@mail.gmail.com>
References: <CAPDyKFoB+r7KMdbV-svz9d=WdPm1Zvd6oZppzbsPDWqX7YN_Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.385200-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2ov59IrsuHOQvHkpkyUphL9EtdrY/Wb3fPagsZM0qVv16Dx
	dGOQK0e05JZCSInyPcTiDsO2i4yReqgHoGQqnHWREwyZyuMQ410F15s6prCIu92syzTqbBJqUHw
	ogQlwTkld9QijPIgKRT49AUJcbsuYlEx3ASJaTY0XrP0cYcrA2xhH6ApagZfOnp9KgXcu34y7SB
	OwG7Q1A5zfncsmAkm5xJSRiaNdU9w5UybSecwyCIlmrWVDo+jrIaVkFIrQFhtoMXogvMW/faPFj
	JEFr+olwXCBO/GKkVr3FLeZXNZS4EZLVcXaUbdiSimlDBPA/qf+8wzIzvZabdPgyKLYvQEwaKgC
	DeFIijeeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.385200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 86F016D48AA4A86D76978ADFC68B60A279B90159A94926D440E21652D04C57C82000:8

From: Joe Zhou <Joe.Zhou@mediatek.com>

> Thanks for your patch!

> Doesn't commit 66c915d09b94 ("mmc: core: Disable card detect during
> shutdown") take care of this problem?

> Kind regards
> Uffe


Dear Ulf,
     Thank you for your replay!

     I think that commit66c915d09b94 ("mmc: core: Disable card detect during shutdown") doesn't reslove this issue.
     1. Issues may asise in the following processing.
     sdcard hot pulg out:                                  SyS_reboot:
     CPU0                                                  CPU1
     _mmc_detect_change() {
     ......
     mmc_schedule_delayed_work(&host->detect, delay)
     #Step1: call delay work &host->detect
         mmc_rescan()
         {
          .......
              #Step2: detect SD card removed
              mmc_sd_detect() {                              ......
                                                             _mmc_stop_host (.pre_shutdown)
                                                            {
              ......                                        #Step3:_mmc_stop_host() cancel detect use sync
                                                            cancel_delayed_work_sync(&host->detect)
                                                            #Step4: wait delay work complete
                                                            }
                 if (err) {
                 #Step5: host->card is NULL
                 mmc_sd_remove(host);                        ......
                                                            #Step6: wait delay work complete
                                                            mmc_sd_suspend (.shutdown)
                                                            {
                                                             ......

                                                            #Step7:_mmc_sd_suspend claimed host
                                                            mmc_claim_host(host);
                                                            #Step8: use host-card(NULL pointer)
                                                            if (mmc_card_suspended(host->card))
                                                             ......
                                                            }
                 mmc_claim_host(host);
                 mmc_detach_bus(host);
                }
             }
          }
       ......
      }

     2. And in the version that includes the patch, we have reproduced the issue.

Best regards,
Joe
