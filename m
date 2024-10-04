Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5581ACA
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032320; cv=fail; b=SJoOwMaBhtM4PuFEctl4f5RtpSxBfhw/AdkvL0lMucEmo8KlEWc25w/qKayB0B6OMbM70UA3utETUFfNS7HIPe8A/jGzok93MulQfqNm168jqIv/pusoj3nokmQm1q9sffQtgy71aswjkD1E1P/kmW6uB2nkLnj0zM11Pl+3YEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032320; c=relaxed/simple;
	bh=DRdsVu93gm1KqK89o+gMrFjAj+8xHIsS8oSC2zonrRE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQeVA8uc6wDuRsGhxu2My+oCY8eRJsVnfrVce8GgU43BF/DAkDmdT8GjU30BAysQy7LwLdylWxmQ6TWe8xAUHlKb2593SORI9KZHKa+vn+8jctiMeWpDiDO0TKJeh7tsgkBVt5TOVz03MCcImE+cKtg9qUCFx90kKeCnV5b0cRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QAO1BRMm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BMhGl9k0; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QAO1BRMm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BMhGl9k0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728032318; x=1759568318;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DRdsVu93gm1KqK89o+gMrFjAj+8xHIsS8oSC2zonrRE=;
  b=QAO1BRMmJhORKRpkwlfr1XdPypFj6KyR3VAF3Rg89ZnXKVRkVwEzo1zR
   YH9yctoTFgb7PKdyS+WpaGsFfTEDYe0Ak4D25LNwxEscKU5HMlzzivSPL
   gcklRMyciaK+7p+DTtHv4w8znnZ58pNtKh9Y/pLlaQFn9jiSxhkX5sYyA
   ztMz4UIJ8Gdv4rTFWr5qgpfLQ8f4LGLJdMq6ZRXEMqIx94vp1qV+hiNKb
   QiWEYJrgXy4ZruDKq2SLYp1Lsyejvvr3GWlKzRluixa71goay6W4DKakc
   upqFxI0RZUfMXNQ1X4br4UvxgE96Z5pV9HDuDnlDQCJ4IWrLC2L582UdF
   Q==;
X-CSE-ConnectionGUID: miE5+Hh3S5yDthSjK9qlYg==
X-CSE-MsgGUID: OVKrbMZlTj+IP8s14sBv0A==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="29313058"
Received: from mail-southcentralusazlp17012053.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.53])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 16:58:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfYTub/ooy0cBC3cGHTZDe3iApFm9+k6xc2MbGCNce5gbaceHbyDFfUtMHwjyqYxj5LDKuFkMEmRxwqxq84BIyLlNAaifqOaWyqN0AEzujxiwGk/hDpyqllw/jLhIbyci4vr4wr62F6jpGmaGF0WjDWuJKxr/8JCZMC1U6684tLhFckB1tZPrTjdiwfDJip9U9iGb9E5WfQ4MVM0RWWKL+my2DQrLvOmBWEV+7Iyv1G2IasMFBjOdS7W0+fpvRWQEtx06vubH65Ha22/UdIhWnu6svJTjAkgz9+qCTNGoACmEjWEHlo7h22/wgyjrKN2ufkMkxDf0onN41BkQFboMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E63GVSwUpzDbbrr7bi2jI5YK6O/B/jW6SCNjySvEvr8=;
 b=y/hwGjtm+hcpf7gvofysEbeM3dEeQ8vB+kytnawA+bpKFATskNb++0uBBdPOg6bAJ8fV1FSOclNByjPW0lSshLfUaYgghDaNkFt/fyymzAFkz7K4c22AVIlWP+7Woet2Nj8YCr9CmwKcDyYXJc1BDj3tK3yG0nLMctmMYOovPOM4Ebq2EdQqPcTmVhtLXZTUl/DAEC7GZ1p72YrMiypun2zoRmDozres1JnMZq9jWpzkrVl9i1p4bNzPI4PmRV1qYLjegWfN91td1OTpi6iosDVsyIrqC8NAWrZPmSmtqrYDIQVPOdJugck+jAmL3R57KJ6zSA+Lege3zju3SVPv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E63GVSwUpzDbbrr7bi2jI5YK6O/B/jW6SCNjySvEvr8=;
 b=BMhGl9k0YGLnoPrDFGPpyBhOkdYe2qr/LQgozxLJXI9q5scFteAqFjevU6tPecfRJjXxmlhkJaetMC9AHx9/uqlCiZD4prHYCKBvtqNMaQWlsOn76AqsV8mdeI4YoJvc1MtzWGww45J3d8Q4IiorxIwCJ/SoPWnKj7WmU60iy7E=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH4PR04MB9338.namprd04.prod.outlook.com (2603:10b6:610:246::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 08:58:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:58:34 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Bean Huo <beanhuo@iokpp.de>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com"
	<vfazio@xes-inc.com>
Subject: RE: [PATCH v2 0/5] Add multiple FFU modes based on eMMC specification
 6.6.18 for flexible firmware updates
Thread-Topic: [PATCH v2 0/5] Add multiple FFU modes based on eMMC
 specification 6.6.18 for flexible firmware updates
Thread-Index: AQHbFcOq+D8Vppc/00mKkAwlmqeOnbJ2QlkwgAAEHZA=
Date: Fri, 4 Oct 2024 08:58:34 +0000
Message-ID:
 <DM6PR04MB6575BFA0432913FF69898E23FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
 <DM6PR04MB6575B11917ACEC21FF21B5F6FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB6575B11917ACEC21FF21B5F6FC722@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH4PR04MB9338:EE_
x-ms-office365-filtering-correlation-id: 3481727e-ec1d-4a39-5bfe-08dce452ba95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UTe/OWP8GxTKOg/78ht2h+b2LI5qKyUBnVKVlGz6HQ7FN1WpSAq4+badGhr6?=
 =?us-ascii?Q?mVkQV4egoH7NzLEeZFt8AOHJWLF4Iztx8/sbc6+kTC6nkLeE+rl/VC/Vk8I1?=
 =?us-ascii?Q?w9E7HwRvY2z0i/iyRXSBIB/N0nS0UIvLEz4/4ikcZLQ/DAhOlamJc/YHb4R8?=
 =?us-ascii?Q?OWk6G8HbUppgIDX4b9vrQXivYQy/8l2ySWfljBsJQ/m/Nmzgv/Lvypo7VYCE?=
 =?us-ascii?Q?xU8bMAPXuK/Kg3+rtJMyNIRvrCEC1RJo5CguLzmA41KNunWEoUrt5fBRNzKW?=
 =?us-ascii?Q?lInAR3a3KZ04eTZrTpBoQrpRbF7xFvpNY6HZ8hSzUrO+nZ538b129cg7b58R?=
 =?us-ascii?Q?nVzE8LLN9N8r9YiBxH4Juk4XQKFrNGNyVddBDgdaNarZvqaXO3CP9PWEbDeM?=
 =?us-ascii?Q?9OvVHLxI9rXm43fPzS/wOrdEW45o+Kn4n4+GgQVyRzajRNXl4UAQApFOvdff?=
 =?us-ascii?Q?3wKZt2VFXUjqYxocx7R32tDGDPMo1ACganWuKj3y+OnO+tjAWpSsqHJ2C1TO?=
 =?us-ascii?Q?vRPwnwpuquhJOUKO/bYeTSJ80kdytS9q4HlzO47wWXXfrGGprJsR/djQzaUI?=
 =?us-ascii?Q?q4bl1gfepWls6rWU66jG7+boqDN8h1DED4/nnOV7fxJVvT0gc1aupUeN8nye?=
 =?us-ascii?Q?01We0LkJbp0Cvg/oJJHtKL50WIHpXjfOiGBq/6ZlgofsLZSZKGWyP5HhHcuv?=
 =?us-ascii?Q?Xp8IdZ+sVJY9S93xKK+zFLUIV9ezWFZ04iC9w0BQxKt0IahDh6AynlQpYBhS?=
 =?us-ascii?Q?dqBVsImf9CsdRXFlpkU5Rh9nXBM48ptZHSsLhE/kgj1SD4KxyfoMkL7y6x7f?=
 =?us-ascii?Q?ef0EGBZRYQY/xuI2hk7K0325T41nS1zx1VS07YAQQU8k0jBWmcJariT/UJRj?=
 =?us-ascii?Q?yxMLIAu16yDMV21HWcRjGwFG3R9TRoa351U5EfJhRJZTU2M+xB+UbPWg3TRd?=
 =?us-ascii?Q?rQAHsVjz063NbE1/xQqlYWxgX4uuuDEwdLiivF4xjgBYnILRZ1XXtwrkAqLt?=
 =?us-ascii?Q?c4bql64Td5rtIKBpxx/65YUmWAuuzb5tlTr6YouPrqMuH7QqEMz7PCUvl7Is?=
 =?us-ascii?Q?f8Zj2LWC9CrXsQFrW8k/dmDd0V9Pi6VK1RUJNdZ4pEym6hWDvyNt50Yn4tAq?=
 =?us-ascii?Q?UzUi3uV7UweD+dPsGpd01NdjfERT9Wx8fyS4i2Fkvh4yZUagUHnFPlzNcfE8?=
 =?us-ascii?Q?Qzj/TxP3CbPIfqAr0Rl9uVyL6TWcVnBRyHYtOBpgYcQyAJIfxNy/7R0ZZeO+?=
 =?us-ascii?Q?/fsxsojkZpsVprVIBnrBnd7FhX9fP3LmZE9fL9hl7PNX40uBOqw06AjeKzlG?=
 =?us-ascii?Q?P045UGgnb6g8bGnU/rpI8WRt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BdIphwIFU67YRvoZ34re37G2tlOlbiqrfE6wq7NokRFPh9Mngvz8XhIxoLbg?=
 =?us-ascii?Q?6VJxtRDbTPVeXm8/yx8NLJdoRQX1iSZ4CzDTEF7OMtb9X0lCEgNYuK3aitsQ?=
 =?us-ascii?Q?0HtOAPftH1iHK9zFcavqIcTEO98xT/IfXGQaERYEu28ABI1rhx0eY2KffMpU?=
 =?us-ascii?Q?tAiLK8sSYCt2+4OnIobZ6vtVFA79Q/Sx+3tP8M0Xkrno+ZZGdq4eUrBhMSsG?=
 =?us-ascii?Q?4JVhyVScM99CB6YAfP7HDb535D9bL5ZF70axr5EXX+xi0GW/U0Gx+s2xgOjM?=
 =?us-ascii?Q?pjzal2geIWRRMBFpr0IKxr3OOjKubAT2S8fXsBxvHSiZdBBZh0MTix/zeh9f?=
 =?us-ascii?Q?kx0LYNw5hZyXwlZVykE2SN+GCv4bXMSbWP1Uej98PKIy/DTLl4DJuRmaDtUe?=
 =?us-ascii?Q?64NgTC3uIfGg2B5HHmi2Z4hO4exE1Fcyl278xhR4f9DQ+6cBdOrP0YdS7oCM?=
 =?us-ascii?Q?2w6rcfVuaeL6PjT4z413HFbStxFkBXfUIzyflBlIVvxqG8fkN0qQ/v3dGPAJ?=
 =?us-ascii?Q?qWWgbxGlspZNxIlO1+PcC0Ih/0BoqW/JrbOpJYpBb0N/xnAVkg2fQ6MDt7CS?=
 =?us-ascii?Q?0FHLNWjZd+stmF/6i1gR3wP7GauLYFKxCEdGBf3/0awDS+PcJFmNykQ9afqe?=
 =?us-ascii?Q?TbdAXI0SChIdTw7Wy0wPhOrMWubJiSR78UCmZ71Gbnt+WxhHrt98HC04ViT3?=
 =?us-ascii?Q?zTHYV+bFsm/sktzJpOrewGtGDuANUdLz6Wk49RTsoe1c6xp9kXTWMYIj6yk9?=
 =?us-ascii?Q?VWm04x+WP0xGbj6rmbNjuRPZ32l11eaewQqRXGfsa3gwbkiXqBhxqUW88uu6?=
 =?us-ascii?Q?+HG9hjK4cYoEDeqEabls/iHmLNaYnh1vnZ7flPhT2pyG02nUI7OLd2ReGaFE?=
 =?us-ascii?Q?D+0sbadK53vs/832Cg4oCHwjOzvlk8/SjHOKcO/rfGc+ZYcDWRr8Mmv3EcQU?=
 =?us-ascii?Q?p3TxstMzrp7nic6AhDHr9cEh+gd/hbOd2SXre1MB+5mnfWerJl1+jIqhEgCa?=
 =?us-ascii?Q?drh4iHlnC/b4Bj2HARmZwJCqoGa3YHDI+LEgYnDi6ZP0ALQmmuB9bMrbDq4+?=
 =?us-ascii?Q?6IM4/S/E5Cfy/vOOllZtKFzd9ZCff2Y3PWLW4RWHqxMG+luUcAp1fnLbi25Y?=
 =?us-ascii?Q?TFfR+3JnFhTQGr79KAfJBk0PzEa2MoOtP9sbV2RIZfa7amRjq3/w/oTZgp7c?=
 =?us-ascii?Q?Ewjbgd7zsEzqfumMrYvKnJWy4aicgIgwhAPCpD962ej0x6sdOE5hubPbogM1?=
 =?us-ascii?Q?QICiDji2po4+6ctUKs5MYs3a4QrxoSisIHZKXd6HmcKbc8gSnuyC0AIFrcZ3?=
 =?us-ascii?Q?d+1M15vKm8e4UG6vtJzhRmB2wlwZfURX+mctyLUZagD3Y6oIQD01D//0rWYD?=
 =?us-ascii?Q?L/J6iuP6sJB3A05UBqEJz9cBtztQA3PnVlYcSzKxh4NDHclLG76mNjpACsDD?=
 =?us-ascii?Q?HuFjX05TwI8YFnrJLy8Fxh+rv/3Z54dCOurEfbPYUCch2SDMc5mChbnUVa4J?=
 =?us-ascii?Q?rjIRm/KTFwCb/X5DRJSAXu6DQ5vjZ0KNW9CFGmCkRMNNXXgK1wlTvR+PA4r8?=
 =?us-ascii?Q?CCmRG1L6XajjIjlKuuthLQYk22IMyp9olesr4lixpN3p/+y6UvwFqnhmT3q+?=
 =?us-ascii?Q?nuhm/5mCcWlGjm6HKQ+kaRD1iMjyIk146+yV8VR3Fhc1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	krnUytyipYfkxQgIls9lOIpLHbSaJ9aDLxYv+V46MDWbbYxeUJK7fK/hm5SSolCQLovRgKFAiAH0/pTm9jIitobZrlLF8Yx4t4KFSnOr2PXSevW0y9TU10h6mC1loHJMwCx7xZkG2Es8hwlolxluy6ddyokgyBchdiG0bNM62rSMxlowkY3PpD4cMxyB7wcjFfjj82yo+UjZpYPJ2TkCpqi18KTU1TClnxfqirhx3sG9apOkaXrKnU4D2d+ungEekJj7fGY8LoMLktUnJhzkBZnJIH6X1vryTBIokSJ6DL6GW893QgR4JqKqorKdUY2PDsaPD64cT8K811o0jwmPj6vbvu/AKRSbm9f/yk/BqiWhE+KSSI0WMNKftiwy6n9bHniWg9AHjdZFJZeIBhilS39WOyXz/RyP7HeSpXK1iCQww3vB794RaIU3hYuAFoJ07RLtz2DMA0gKVQxaTOXEfU5tvgRgVojziOA9XPm5H4VR19F+3nfVALVUkH0XWKMfcac3eBc2dY96AlDfebuahEJr9GOjAUy6roy65NDvPbJAPblW8Jgnd0EoidMvh/saonq65Xxgd8Ryig5wU/p3EXbI+mcC90JAvfy3w2l9udz0RvxBa0Fv75V10MW2hf/w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3481727e-ec1d-4a39-5bfe-08dce452ba95
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 08:58:34.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxNHYghAcyxsgGfbYo0oKP84OetGcMjPci5DSugu5a+xxZfTQ5b+TcU56vbWAQqmbZNtwtIDO2DSOMhXNGHvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9338

> Hi,
> Thank you for this series.
>=20
> > Hi Avri, Ulf
> >
> > Following the discussions with Avri at the 2024 ALPSS, I am submitting
> > these patches to introduce multiple FFU modes, as defined in the eMMC
> > specification 6.6.18.
> >
> > The new FFU implementation can support diverse vendor requirements and
> > operational conditions.
> Ack on that.
> I concur that various devices may respond better to different mode.
> Thus, allowing different modes to choose from, improves the overall
> operational stability.
>=20
> Will try to review it early next week.
Gave it a quick look, and some stuff concerning your design pops up:
1) You are changing the api to follow a more common optarg mode.
    While I agree that this is a most welcome enhancement - it should be do=
ne in its own designated series,
    And in a way that will not break the legacy api.
2) given the extent of use of this feature - I don't think that the api of =
the current mode (default) should be changed.
     Meaning people should still be able to run ./mmc ffu <fluf> <dev> as t=
hey always did.
3) Essentially by adding modes you are mainly changing the part that encaps=
ulates the content of the multi-ioctl.
     If instead of adding a new mode argument, you would add new commands -=
 I think you would end up with much less code.
     Meaning, we would have now:
      ./mmc ffu <fluf> <dev> /* the current (default) mode */
     ./mmc ffu2 <fluf> <dev> /* mode 2 */
     ./mmc ffu3 <fluf> <dev> /* mode 3 */
      Etc.
      And each vendor / FAEs / validation team etc. would be able to choose=
 whatever suite best.

Please also note that we have a man page and a docs section.

Will give it a thorough look next week.

Thanks,
Avri
>=20
> Thanks,
> Avri

