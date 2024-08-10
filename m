Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027882F5E
	for <linux-mmc@vger.kernel.org>; Sat, 10 Aug 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276705; cv=fail; b=nI9ZhyJhCndEU/TPiZl1Ca4M7SABRoQAHKJLueuB+thCJsD2tXhxZliyK0f1NIR8CBq/KH4dihu5eg3Z6BNdaXvVXJqUwOq5Z0ZH6hs75f9KVk164n9C784t1MAboIVHVLlsqXdyAxzv+0CTsE2TJ4vF9vGYPIMQC9DNt6PDX0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276705; c=relaxed/simple;
	bh=zWnl/s2ulAaDS3ytaOdCSQPGgJPMuV71QHURU58eTOI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TR2bDl9bEgy44/a03bKQuD68o46TApBrq39nzgjPcXyw6Xv4MfNrEci+V3wjLIFDqcGdl9E/c4IrrjsYUTgM+RnfKNkda+es76iF666lfR/KFGNb21xhAre8ebNaz9cvzmtCsw4FZUv7aSQuQ/AaGH4LJ5CSL49ZO4iS6RnPj4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=af8VOcc5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OFC9bDkR; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="af8VOcc5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OFC9bDkR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723276702; x=1754812702;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zWnl/s2ulAaDS3ytaOdCSQPGgJPMuV71QHURU58eTOI=;
  b=af8VOcc52H5urwNIv0QUULI9G8usWgywtWS5iBxj/QYdFb8PchHCqF97
   QwB6tLjIWhbmIJW2oWffjT05OvppqP7DI+Xn/ECdSVUP7+Q6Vo1M1pUXA
   yeOWzCLNOL6oYUnSA9ej+1Wux0xguodYRrql5ZQPd/AeWzfGYOBiHdjtp
   UCO9m/eGlhjkzYquY4qt8WFXcedhzhkDQYsj55C61CwlYAKYJf/cCHUwU
   wZR1AV+8ydJuWrz8nyOBgAW5w/83HBWiKA13jJkKEKdWfmQAd/pAhh89b
   /FW36krwChIlD0HhsvqNdu6MYJiNla0ZvyD4wpfFuWhnwxdkm7ZN3aQTZ
   A==;
X-CSE-ConnectionGUID: dD2aSflyQwG5GljKgGpqfQ==
X-CSE-MsgGUID: H/7Sw+9ETJG9XKmfcKz0yg==
X-IronPort-AV: E=Sophos;i="6.09,278,1716220800"; 
   d="scan'208";a="24688293"
Received: from mail-eastus2azlp17010004.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.4])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2024 15:58:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0ptebTYhmxZKwORlBFYhzQsgmUglqZ0V79iOpa7W3b/pZvoMAkP0xXldUxHcZo9kCW8W52p54ePwON0pLLC1JzOSr2Umx7MA7G1qXuITiDY0N457wWC6rhwCGbyl4Yu9KRU9VEwYljpvg8ogieH7fsvRKE3g7eBWMAhwkPZRX2jQhfvB7xxflZUtljUhhWcLbnVPGJSP9H5HKjmAEz2sd2UuR7OiPwQp1Dz6H+Lq3ZdJxOWs6jIbblJBSp6GDc6l/0e/IeSAfMrabzuAXlgh60tUUZt2dF9grfxmuOnXcdEHTWMyrElxAhShJmPJwRL4/ScE6phf7fUPd29iUxGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAJCRkJyYRpm+3OvzV01GdBWR9nWxNE831f1t9Cypj4=;
 b=uYGb3MGAxpRSHc2n4t8F7D0rSkOcy/QEt9/h5AZvtBtYFpn1hzjdveq8mbp2pGiCebM0L/D3CsGPo9BObl3VBzIVeUcXOJy4PWQEzMNxmFLms+QsFUIQbFpjr17TvvsDyLJpMxg6MA/zhsJqKshnMxH/pDMyJwHRgvSpm7orOT5DRIKsw0MEcOQwkqP77N2y20CzEv5s0CoVMWQ7kYxHZ2s9+KpmsWBz6eLrc2qBMsyTOdMtVexdXnicFrK+IFzDfcmXLys+wljEdMz5DPfSUp1c3lzxNMiR0rtxDHRPTbNfDtucLCL37gharQrmTNU0nIQwXPw1g2i4yPlmod0V6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAJCRkJyYRpm+3OvzV01GdBWR9nWxNE831f1t9Cypj4=;
 b=OFC9bDkRGoVYY46qJeyA1m6awlGV865iBPJvDzs9VBCViqhgrKPAje9A15jeU6v4Tjdy6cCOx7ZPyLgGEPk/xLY5yWMGSSDVh+3RzT93c+6XnShPIEEAU4Mf0ILUmMqHoHomUaqDSjA65TwQ7uNlFy46f0AGpNW8FABvQ+ZihYA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7425.namprd04.prod.outlook.com (2603:10b6:303:78::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.15; Sat, 10 Aug 2024 07:58:13 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 07:58:13 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ricky WU <ricky_wu@realtek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa6I+3UXs43GPn70qM59vpv7m6PLIesvqAgAFwMXA=
Date: Sat, 10 Aug 2024 07:58:13 +0000
Message-ID:
 <DM6PR04MB65754CF8B3A986A88FB0A517FCBB2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <20240807060309.2403023-2-avri.altman@wdc.com>
 <9353f3aec3e846dd9075ada858d44fd4@realtek.com>
In-Reply-To: <9353f3aec3e846dd9075ada858d44fd4@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7425:EE_
x-ms-office365-filtering-correlation-id: 435c723f-60f5-465f-eb6d-08dcb9122f27
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?806lFgf9BQcc3dbZl04VCnHH099B1Gx3pVETU+6Ztw63zDUTpufdysyVmzDL?=
 =?us-ascii?Q?UVN8jL9YDHzSKrmGehxgw/VrY0nbHi/Xux5L30QX2lnTEXZ3rCwoBhTORdw8?=
 =?us-ascii?Q?NKfJq+3QkPZdAI1P62RdcFUua8GIJYl7fBv48UxulcirNgIxsW4rxFTP0KLv?=
 =?us-ascii?Q?qlTWBYtiGDDVXNOcH8IRpgLYIX4RY4qIZOGaKuzZ6ZLNvNLGz8okcCqBtScU?=
 =?us-ascii?Q?H04Cjc1LhBDotDOqaGj3Lc9Bcg5QPaxr37DTP9HAYeI2sG6xJ0HtQfrs3GRR?=
 =?us-ascii?Q?AswICSrRuN18HBaSewbPjXSrS7ub0AzItUpjXuZY+vLcSYRY0HULmp9Ktvnj?=
 =?us-ascii?Q?IwXxGAaaXzMtqGaNEe6aQ0/xAgsVQN/G0sAcc89UStuiIXLe9UDIKswjNjwq?=
 =?us-ascii?Q?VR0P2TqZjXkRPHYJ9Pc574JozpfsLPhNe9WXnT8F4UKKsAEFnoPbwGi7kfss?=
 =?us-ascii?Q?TvHOFx9/ZonY5WSio2vbBDlWktZOcdTHmJJ2/154twJViyE6n9MoJwerjGki?=
 =?us-ascii?Q?gP/712/uPp+YLWoYXwU/TIdFyuMgbCxsqvu1OO67PTYF2rFOGF0XTVIYslkL?=
 =?us-ascii?Q?uhcTR4hyYozEIzkV70EeH5t0V/sbmpolrSwzyOtx3LZ3BY2Frg71/fPJYuQ5?=
 =?us-ascii?Q?mWSh8wRvFjmDP3ElfIyStfD6z3mD36BqpQ/ZIFS9m94ixFo8zjtMiTYmo0s2?=
 =?us-ascii?Q?M61zWRX1JAlqy3YmlGdSVOYSSdYBL9oJudj20ppwAOR4atb40cXUpCeIAQw2?=
 =?us-ascii?Q?ESWhzTe4OX2ci1yqDSlrh0IJTcmN3XTt7TU0VaINl2uT7oGWMmt1GXCPK232?=
 =?us-ascii?Q?5wjj3LZXmGODqZgwW9dODez8hMvyo9CEjKSobFCnzgWPf7JvRern8jHBFpLD?=
 =?us-ascii?Q?mIbKx/UJLW/E/d3cPBXWXofpbIo53oaJFNlvDwVY8O0v5GvMwBcrcBREJSNS?=
 =?us-ascii?Q?0Nt7+kTvvkWZW+YG+GZ2RgkCZcfKVZXZXkqp9iPwHNrq7pkhwMycJ10zRXYF?=
 =?us-ascii?Q?Ip8Xbpv8X1m2q26Lc5XSPXPWplcinZaaAcJ5eiPLbq6d+P5SIGcriQGpR17b?=
 =?us-ascii?Q?beiUVLwYxikwCO16jv+vqZn+MlFxttzkveIivzgcLrsPEtQ350cWiuo1/VvC?=
 =?us-ascii?Q?uKUliZFXgfbdqmBbFWSQkHK0xL42yFu7jY/lgpUtOr1p7M7+ejbxyfjdBloE?=
 =?us-ascii?Q?+W6jRaZI/fyIfwYSwciG+NyRFZE5/1bk4i/Zi8toFJFIGKIbUzqjyHgv+Ni4?=
 =?us-ascii?Q?y3TAgajuCnahgmppgvT5ivP/Hby04Ww18zQziWYmrJehQOUVw5ssEjl28c7i?=
 =?us-ascii?Q?61yDzqtDB/UrQgL3bWwL5JqpOohjUM0YW0F+yzBGAr8CnQwnJCMrChOX2/4/?=
 =?us-ascii?Q?kNYGTxneFk8HAZ3oWkRsYFZs0lw7cFfKPiNOCjT7Ev7J2pl9oA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iDcVI6+KUP8RSe/1hdIYF/YIRQ2eJCPENE5FsXH29h5sR/iOeeBou3mC24BS?=
 =?us-ascii?Q?7Rld/8NktxP/RfBn5JsWwvazbb4g4to/M5KqHfhqYZyvjtczMX7AfI2J1zF0?=
 =?us-ascii?Q?AiAgIswA0D8no0FAZkPlX673FgV19kYCvptMAcE9+ecSJTBRHXKdIa0QF14U?=
 =?us-ascii?Q?di7zCY485v349BUBnaBiCZsa2+Y/kms99F3L867q4xTQsRpkdB4NkwI8l1KV?=
 =?us-ascii?Q?kWqXrPH7D2KiVLyU1+qgPW2KlRzAgdvI5/Il39Gy8T+GG5vDN+r24Uc8zlzX?=
 =?us-ascii?Q?WntH2O15UxHHBg4Gh9H3AZMOhm9IKUeKuDPa5kpJEXfm41cWy22jvIhhIFQZ?=
 =?us-ascii?Q?RmIzN8GMYo0BSAM9tk2GMOVnydE0BVyGiMM7lPA7gdxtPd+jiUifqfjD77Xe?=
 =?us-ascii?Q?uOT28o4FBC3qdfSReq8Ej6j1kiNLEao4ZBQixSfZvRnN6pk3H/6xj9UJtlfA?=
 =?us-ascii?Q?kOVAn2eqRlJUvmpWuY6y6Lv0lDjLVjtIMcWtxZ8uOtiH0z0jjWRUkDs74FjH?=
 =?us-ascii?Q?foXSiU71l+OB7dJ4e56S3E+m8HD7i8Xi8F8DsCTQ6EpJRn/udevf5nOqHIHH?=
 =?us-ascii?Q?Q+jOEPIGysUZQPZlbZS1L2rRa7CSOmR9UivSMsl8ANVDtEqF6dadt4HCtshL?=
 =?us-ascii?Q?bdBzipMzRxRD7QTUx94lvP1EhGeQfQSkWtmbDGUsT3PA91idU9CZempExW3O?=
 =?us-ascii?Q?c/r5HzGPbcGDaGSX25n2RuJytJFAcBYYn9SFR9p3JkSuS9yFwLA0tw2ur8Xl?=
 =?us-ascii?Q?SxO1vpfVnoz3z+/00c/O8qRbloYaEbnRE70oAdj2ty1TINBE5EarZHO8FLC8?=
 =?us-ascii?Q?HJa14//RX9UIBZEhr9bzgZwUrkgkhHszG5Gr2PHTA0KDuZ96/Wyo/WqhU/lr?=
 =?us-ascii?Q?RdYvRU9n/5JEa/mctRUD3WGjM2mj+83YSJNwbLiSfVeGDA4HzKWSjYLfkR1V?=
 =?us-ascii?Q?NjmTDJ7z9AGWHfq0QZY/GwtiaFtQlxCIAqOKIQdrY7EcfFaLkXzniFa50A5w?=
 =?us-ascii?Q?q5U/PXmmG7xlhBmxN3dCa8s1quaFiu/NExAMMkHcSu2I3AeEjK/UhqK893Ql?=
 =?us-ascii?Q?tODurekPAfIVw+/duG6woexCtOlvDtpXmuH6MdDCTC554phQyCqcca44RyOW?=
 =?us-ascii?Q?PxyclBWcSn35fCxu8kpf3tqUZYuTtJx2pxR5zRg5c/KP15+lNRR30mZHN9Zj?=
 =?us-ascii?Q?6IRBRkNcLYpkdYn5RKVEyP1aVDqCCkRebHrph+NWLEqWW2OFgJfWUtOueKSt?=
 =?us-ascii?Q?jkgpwTuJXrePK4DLdbhHqIpkOK1VU5NELbjyk5JFQesOOsyvrTzs78xwXADO?=
 =?us-ascii?Q?qTLHOX+JjQ+wtmlg+PG1u0X7YTZhWjxi7AjH5Ho5uMqqavY3o+3WKdxtJ68O?=
 =?us-ascii?Q?6VPex4DdqAATyaZBEWjfk36s8HHyAd9k5JxIHj9wD3URZ90OcD9v7zUwOO/Z?=
 =?us-ascii?Q?DAy+tbg8pzLzrkqQqVdbm06Gd7f8KHaxAZTXzXas4VLGO/kwUQFAaolQCKuo?=
 =?us-ascii?Q?mmE8ef5MOShjB0IBYuhf3gepEYwb8Ob8Zu6LMNADQgfzaavSj5nTYKEHXvbl?=
 =?us-ascii?Q?2lOjhkidqQX103va/WM4hkKEjzk8aBGsEKM2sAg5?=
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
	a9L+cevHQTEPSyUCmSRTZ8bdLv2m7xwDY3UJn3ktCYVhaeW1K8muGay/w93tkw8ZxTI7oFGZRBoX6hOcNxvUfkrDU9slqmb/9plbmetfT1MDpi1G22WYgKpXq6Ofhnt3Nky98Psp8C/I7xDRQ/bqEh7Of3Qh7Y9QCAb2ocvGyqQSxeZK0MZ+yxH5sE3alcziGEGrTxUNaA6VaOa3hL4xnDbR70LiT3iLJQm2X9Sx+qDY0BJDuDjg4NDrQ8zQ8zK9DWUAFnBzZLE196/PsanY1Zz42tvAejF7j2PXwynLXvKzcIF7z1Fio9T8NREcVInzebbaLDNt61X08vyxkqXNDi5fW+a8T0y/jy0NE1xsc7RqC3j5iiCTJ01eggOyF5AuGnQ23AzKMkz7KcF3GG9ZazSknrjmVnD1/OF2LxlkXDJ06TzuEizSpIkn4jae2T7TqtxbdU8s1h2/GjucJx/pdIvtMZp+ltDCiE9R7TJiQoXF/4pnYqjjP4QYMt7BkMmDKanUlDnFmmM2/JgZBMq8FAW5ZNujS8JjHshx7H5HCxV4j86lF5X/PO1tck1l1v0OevoguE91LPIi3Q4zQmDpI/9nXeu6ZURNh5a55ESSQguQx/R3+7hj45XHpQqst14P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435c723f-60f5-465f-eb6d-08dcb9122f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 07:58:13.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bt9Ysjz3L/ZtIEHPJJJHMjlaIBhN+VNRRHzp/3yK3jrpQNcWlCVdyWgp+X8nX9xJdp7gvj27nkY+XjgPUXwAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7425

> > ACMD21 was extended to support the host-card handshake during initializ=
ation.
>=20
> Is ACMD41?
Yes.  Thank you.

>=20
> > The card expects that the HCS & HO2T bits to be set in the command
> > argument, and sets the applicable bits in the R3 returned response.
> > On the contrary, if a SDUC card is inserted to a non-supporting host,
> > it will never respond to this ACMD21 until eventually, the host will ti=
med out
> and give up.
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > ---
> >  drivers/mmc/core/sd_ops.c | 19 +++++++++++++++----
> > include/linux/mmc/host.h  |  6 ++++++
> >  include/linux/mmc/sd.h    |  1 +
> >  3 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index
> > 8b9b34286ef3..7f6963dac873 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -168,12 +168,16 @@ int mmc_send_app_op_cond(struct mmc_host
> *host,
> > u32 ocr, u32 *rocr)
> >                 .cmd =3D &cmd
> >         };
> >         int err;
> > +       u32 sduc_arg =3D SD_OCR_CCS | SD_OCR_2T;
> >
> >         cmd.opcode =3D SD_APP_OP_COND;
> > +       cmd.arg =3D ocr;
> > +
> >         if (mmc_host_is_spi(host))
> > -               cmd.arg =3D ocr & (1 << 30); /* SPI only defines one bi=
t */
> > +               cmd.arg &=3D (1 << 30); /* SPI only defines one bit */
> >         else
> > -               cmd.arg =3D ocr;
> > +               cmd.arg |=3D sduc_arg;
> > +
> >         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> >
> >         err =3D __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US, @@
> > -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > u32 ocr, u32 *rocr)
> >         if (err)
> >                 return err;
> >
> > -       if (rocr && !mmc_host_is_spi(host))
> > -               *rocr =3D cmd.resp[0];
> > +       if (!mmc_host_is_spi(host)) {
> > +               if (rocr)
> > +                       *rocr =3D cmd.resp[0];
> > +
> > +               if ((cmd.resp[0] & sduc_arg) =3D=3D sduc_arg)
> > +                       host->caps2 |=3D MMC_CAP2_SD_SDUC;
> > +               else
> > +                       host->caps2 &=3D ~MMC_CAP2_SD_SDUC;
>=20
> I think host->caps2 is for host to claim caps, here can just call
> mmc_card_set_ult_capacity?
> Don't need to wait csd, because SDXC and SDHC need to identify by capacit=
y, but
> SDUC can be identified here And all your mmc_card_is_sduc() I think chang=
e to
> mmc_card_ult_capacity() to know the card type
This is an interesting idea - and yes, we can do that.
Also the line of reasoning that you provide makes a lot of sense.
However, SDUC is not a card state, so I am not sure I should use it.
I added it to comply with SDXC, but using the card state to imply of a card=
 type doesn't seems right.

Thanks,
Avri

>=20
> > +       }
> >
> >         return 0;
> >  }
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> > 88c6a76042ee..a9c36a3e1a10 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -427,6 +427,7 @@ struct mmc_host {
> >  #define MMC_CAP2_CRYPTO                0
> >  #endif
> >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC
> > that has GPT entry at a non-standard location */
> > +#define MMC_CAP2_SD_SDUC       (1 << 29)       /* SD over 2TB */
> >
> >         int                     fixed_drv_type; /* fixed driver type fo=
r
> > non-removable media */
> >
> > @@ -638,6 +639,11 @@ static inline int mmc_card_uhs(struct mmc_card
> > *card)
> >                 card->host->ios.timing <=3D MMC_TIMING_UHS_DDR50;  }
> >
> > +static inline int mmc_card_is_sduc(struct mmc_host *host) {
> > +       return host->caps2 & MMC_CAP2_SD_SDUC; }
> > +
> >  void mmc_retune_timer_stop(struct mmc_host *host);
> >
> >  static inline void mmc_retune_needed(struct mmc_host *host) diff
> > --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h index
> > 6727576a8755..865cc0ca8543 100644
> > --- a/include/linux/mmc/sd.h
> > +++ b/include/linux/mmc/sd.h
> > @@ -36,6 +36,7 @@
> >  /* OCR bit definitions */
> >  #define SD_OCR_S18R            (1 << 24)    /* 1.8V switching request
> > */
> >  #define SD_ROCR_S18A           SD_OCR_S18R  /* 1.8V switching
> > accepted by card */
> > +#define SD_OCR_2T              (1 << 27)    /* HO2T/CO2T - SDUC
> > support */
> >  #define SD_OCR_XPC             (1 << 28)    /* SDXC power control */
> >  #define SD_OCR_CCS             (1 << 30)    /* Card Capacity Status */
> >
> > --
> > 2.25.1

