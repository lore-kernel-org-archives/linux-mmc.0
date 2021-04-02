Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3F9C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532686100C
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhDBHrt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:47:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2651 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhDBHrt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 03:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617349672; x=1648885672;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I3B6jC49pW/7QgxPCLRNB1ZIA/iSKPr6K41Egnk08gc=;
  b=X2Jqh0TGDzyynW8lZ9sFPS5jauP7Q9Jo1oLMJMIKxNtsgtmKiFTUL2cr
   d0V1K0EEJ+T76GEXBXEJL8szeTghJm0KCl0jk8Cb3HgAZEhsr3n3gJiip
   zgtGrFez1fW8tcDOpnORYnQAskc5kUZ7Blz41cEFyfEGNBPCO41lyZOyf
   JDUDC87uA1L+CcNxZO9b1YXqKqaidc0oqWWJ9uK2LKRo82pWMHo8VNPrg
   plIwqRNtHKhPwNtZMhDkpjg5vtL9c4NYbezReJltlDikLD45vqasIf8tB
   U/siBSH+SpD1DPkvnF5/MzTve9ea4pBn0qgjb9FX0ER8HHD3lBAtfWdHz
   Q==;
IronPort-SDR: JG87bHAPFM6IvOklwvrKa5JUOhDTbkbzg/UjcIJRJdqcYHbo0HeE9kRPCuUXHdWcTl+8G0Iq4x
 2aX1on7J0tpddSSP/oPEp1inlQDtttbGHsdFUzO96k3ydiUs/NXhJuAs21GhlrYLpW+chy1ak3
 KjNRJyhP+TLn9/Y+lMosIjURsprIfW1rFTAvE5QOuv/KDltEUNHLJNzm6GIz80+hs4S8UdzBHS
 N5xee6D3/2TvQ9ZyN7KbOFGGAPjckhWXGeS56gkaiFtjwVvHwiOCpB6f45K71HetGxcAS8aU59
 nVU=
X-IronPort-AV: E=Sophos;i="5.81,299,1610380800"; 
   d="scan'208";a="268028862"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2021 15:46:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+NqacIm64FAsxOAdAUBqUhcY8BCPHBc1B8xW7Ampwat5j5kZ9A9e1CYfReNThRdo93N4xWfUnqURtTGr2l7NEwQphGotOsh/HVHCVirQM5W3Itt7joFnTocLEaX+HcRQ5tVd1vQrpqhwATGJ3gBR2KPmnoCVRX7+wudakwookp+kuOQn9StoS+Mlk72XI1/bQ6XO3FzBYN0kyrXubGm/aZkcG5Fk8tPDt1bd8EelUVygPOS8cbC8vvF1QBNe0U3pBc90eBlE8zM/ekxthUTqf+gOZClq7OlChVNrdGowYHXYhw5xiAkZMaLTtsg9hxuBY6dpyVoXUinrtFS3AllfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQLj03wqgxFsDutGf5dPvH9zHchpTKioSuv90CUSWw=;
 b=asZUGaAtsX22iTYpwYFgjAIshdVO9RsuW7dO4dz/7Cw4/t9ZXTp16J2tgBoB89og7zAxyAdaJAVSFfsTN7bSGtNBtC05geW6QynmOL62QZwz3gl0vTLgMY4HKZXAfW7lVyobwxijlkiGb8C2N7jYu8TxKgo+9/A57NyEn9X2L719yi1E48tCjuEA8KcbEYH0+Ar882h4JnNdhCeCtGrske4/h0w1tXOGjEzlvxxVwJBhJblKy70MyOlXdl7ZrQjaL4QVwatz4xnpd9Kno/Vaira0ZDwMbOlvYb/U57EhiQLAKNm1pu92C6T21uIwZk2Z2ZkjUws9jAL/28TmASCMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQLj03wqgxFsDutGf5dPvH9zHchpTKioSuv90CUSWw=;
 b=E4hTDew5pXccSzn14Pk3rL8B8ibTGxhEHKtvLps4YX+j/659vLgtsPa/tD+31Fn2j6pjsobDu3Wc8YCyhj1PvytrdroVAyEWobYb0E8JFIF1KKJBn38j+uT4YPhmmgqndBfOTj6gHbgd1H1znHNE85iEzP6yNkvazsvXSddzYbc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5626.namprd04.prod.outlook.com (2603:10b6:5:167::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Fri, 2 Apr 2021 07:46:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 07:46:51 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "bpeter@lytx.com" <bpeter@lytx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: block: Issue flush only if allowed
Thread-Topic: Re: [PATCH 1/2] mmc: block: Issue flush only if allowed
Thread-Index: Adcnk8DrfYl5cGeLTJWc5CWz12wyzA==
Date:   Fri, 2 Apr 2021 07:46:51 +0000
Message-ID: <DM6PR04MB6575658643D2344B4AE027C8FC7A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47c23beb-af9c-4f0b-b0a6-08d8f5ab7a9b
x-ms-traffictypediagnostic: DM6PR04MB5626:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5626BA323B3DAC8E83D776FAFC7A9@DM6PR04MB5626.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6BFO+WHHOScXUvoWdn3NJLK/UMw8YdtdoriZkLF0dJFiSTy6SYTfX6h3xAa3Zs5+UsBiEeKwmnKKL2cMT9BkSLFiyGSC7VOso3TJi/RJBMpJDEZL9I4iS6qjVOdUXgmlbvf7mNC/J5gM4CuKhwfx4vluv/ZRDuwdsW5942wyWtLDPXwSxpng8IOzfi89aGyGBJMmdXufBG/yEdFyWaTEL5YtdF1TbZYbydgbyLRMx3tdbsVLOU4nB1isHq5m5sRTJR/p2BO0hIi91lJjSIHXu55r9K9Ld4eeMffk29kUQPx8WNnE4QZ3bcSfkletY8qIS1fqwexk8XeDmzVfw2vU+lPDwnJljh8o8WBbC/3EajPE7PPcqMbUrDH0eVqBgI14Fv9BYln8tNDnvJGRsCMtqd0zpa4EHkUxgRYteUWahWBbphNzPaJqAR+XNghHDZAajswOa17HWISacsx4wPRXshxKeBrizlBgPAdYGwFT5e7jVm7g89DvmtaNcWtOkf5QBH0IDCARJ3ogk4aU0Ggdm2S7kFu6Eud9/0QWujzVhTRR+Y+KQ+uDZqWIB+yJNqo0hJdXTIE0daIvOHxsy5hAixdezf18JE+lqPJa2A48KKT7qS6FGNF5xjiE+xFvLj+3pYR+vRSptiTf6DI8yddsvsInOd6zAmqBRB0g6jxgkc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(76116006)(38100700001)(83380400001)(478600001)(7696005)(8676002)(66476007)(186003)(66946007)(5660300002)(66556008)(52536014)(64756008)(66446008)(26005)(33656002)(2906002)(6916009)(4326008)(54906003)(8936002)(6506007)(55016002)(9686003)(71200400001)(316002)(4744005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WYQlW3+IgKM+hyckbg6jYvYuc1bN96ddHh4ifOLAOVI/geliYsZsaL4yT2il?=
 =?us-ascii?Q?Opb81UaJqk5Al1ppjG6DUe1E1VPgNrUa9aKAO2fj65Mcbm3C8/qjb9POoOzw?=
 =?us-ascii?Q?zAAe4hwqIXlVlIfIpVRKHzREj0DVWmY5P6vLaE9nOlpCr4noRM5l3XZbbC1q?=
 =?us-ascii?Q?+K0mleG3DOP4T5d1cV3jlzgkWxHLy7/XHPeOvZ8fPSASBaB1PyXirbiHT+tn?=
 =?us-ascii?Q?F3L2TA3R0rttsdi0SjDmeUn+L5xAPJ+Lv0RXPpptZdP/KsXlrEW36w3LKcPg?=
 =?us-ascii?Q?/VT+uDAC0S0hJntqouIubYRU2dunA8yI4FGdc9FEcTOGF1wg7eThkZwd8kX3?=
 =?us-ascii?Q?kduaGCpcPAnbk4ia7V7FoVuoyERAYbqAfBAroegUhFZBUdd1FBoU2uggqk3j?=
 =?us-ascii?Q?wnuDDUJ44cMr7LgGmuXRQb28+fLi4GM/A8FHAy0hc7phcBf1MeN8w/Zrv4gJ?=
 =?us-ascii?Q?y4smwWfQVJWhCcpwlbPaCO+UIn5J6F4oEKVUiPfqEQ2JsABfVaiYXzmIA/3C?=
 =?us-ascii?Q?hPHioxXa/uhWaXGk9gFSL0SjeEKsPlyYmsllX/vtvqt//wHNP8q4tqnz1dRm?=
 =?us-ascii?Q?TQ3nGKA5ParzbrD/iauv5/LI+YlQ2MUQ6UooN6h6RaowoBLfXG3Q1mWxqYlV?=
 =?us-ascii?Q?nrTb6o1JAnEQ94aSqFi+su5W/cVofCIKmUr1f4fsmflBm/yoHmddUahbG6Vc?=
 =?us-ascii?Q?YWbyz3iXOWrtlJA3GkNl/HUwk8xStqDX5oyEp1Q20DSTPu4K+O68XLZu7/gr?=
 =?us-ascii?Q?r20eDZSzSKO454kEGZVuNdItPmiP90zPS1b7El1L3T+Pvo7K1XO0IFMJfh0q?=
 =?us-ascii?Q?5Ekpe1JxBQX3I32Xux55bdq5NKdSWsptQ9c2w6msm1BAKRwmMvLMlHoWQddf?=
 =?us-ascii?Q?pE6k8ct5hmGrjeHrlMgkRnlbL+ZRATYZ74Z+TDh2CtfwieChnhaDHlna3Kta?=
 =?us-ascii?Q?M23qzmqWlcUt+X/CkCSwQEtUY0nNNfsu3NybBGdzreB7tnq6jMnEKL6I2IH/?=
 =?us-ascii?Q?KTuUepAGn5ieosDTkjjOrfWYV3svvSisI9FsjGUIhefzpt0mUs3ebEbescs7?=
 =?us-ascii?Q?fwz25cCS2Aw5iw6FBoyWMSvSlI5SFCfkz/IK4vhjTyE749hFD/nKVwyzmifL?=
 =?us-ascii?Q?1pl8TOw7d9hQqjldis0jSZhsg5xtjuGuJIN3Ch7a48PNU/UZ9EjnLx6SheUd?=
 =?us-ascii?Q?VR0MFp56/xxlGO9eQwWJkxGzmmF5AQbnUuFSwu29lPab7CNfVeT9mLHm17ci?=
 =?us-ascii?Q?9Za0HGCdi4ebnnA9An8Bnfe6m3g8Y4/5CTIOi2Q4zn9XeZjPlEdMBLroEteT?=
 =?us-ascii?Q?peE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c23beb-af9c-4f0b-b0a6-08d8f5ab7a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 07:46:51.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4hMP82XrlmaylOVEw/3UapkRD4fPPxd+d43m+bfQFonempAj3F/8tkFmRAs9IRtg2A0naUtSiiCHfh064MV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5626
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> @@ -1473,6 +1473,9 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queu=
e *mq, struct request *req)
>>  	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
>>  	struct mmc_request *mrq =3D mmc_blk_cqe_prep_dcmd(mqrq, req);
>> =20
>> +	if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card))
>> +		return 0;

> Returning 0 means the flush was issued successfully. i.e. it is in
> flight.
>
> Instead, a call to blk_mq_end_request(req, BLK_STS_OK) is needed,
> and mmc_blk_mq_issue_rq() must be amended so that it will return
> MMC_REQ_DONE for this case.
Done.

Thanks,
Avri
