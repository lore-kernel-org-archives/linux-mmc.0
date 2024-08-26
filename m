Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C874055
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650331; cv=fail; b=fMLhXYNLQDJ2G10N4d19KURqI5da9ynD8atjkyKtKHlBtGKlNDmEyGbBiVdYTig7JkUvZIBAf1RYbgKTD8960OhqhZwvvnQeLnC8ZzUUXkaOst/IT68rUH16o5HCmFacsPym5jO8rDo8GMhWwHGdSc36VakspXCiOpjnHZOcLBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650331; c=relaxed/simple;
	bh=QDgj8kYCN7UZMK8XgPSFUenDn+lZG1IuOn+rid4GhW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mrv57Qr5anKVTLXiSpfwsVnOyFABf0ETSun8Zw7rnUBHDp5FunnNWPMMORauSjbjamuMG0Ku9e5buZpgpqaJz7Zoh1nafRLqqxVbkCuiZfEtRU+wWkCiOUI7O4rYS0U2X16mPy1k8DCWVPre2S+yN0LKIs9/Jn0FWqYCaQPylJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i5cES1Bo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=K0iIn59K; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i5cES1Bo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K0iIn59K"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724650329; x=1756186329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QDgj8kYCN7UZMK8XgPSFUenDn+lZG1IuOn+rid4GhW4=;
  b=i5cES1Bo2NcZiW4VikeDJ63X7OgfNLmn4Xi7trLqhLk/f7ZlQrOK/jGz
   vz9munubGegGQ+XwY/HXiFbTuJ4aFqyL5ZQM8nKCnb0adifaxaCkj5VMl
   vRJ/YDpnY6gU4ObvnfVZBTUq8dQR1BqXTg+F3tmj6N058UaXD7b1nPYl8
   yadoMA7cmM9xauKlyaGWVTH4MPHnwsl/jlAUzfoNiDLyEcaxTNWPU8I8o
   3qaghjIYJPvjrpkVvMuFJC6uE5iKNrzDSB4DpUoLH/aO8gqTFlzFla42x
   hH/Y69Ihd3/TfRduhWZYRWpCgbiGXn6KhLWGQhMoT3NylUOaaKsb36RWo
   g==;
X-CSE-ConnectionGUID: xRSlMMeeQwiBnOB4yOLnEg==
X-CSE-MsgGUID: 6ezOw/mNT1i+cMG+3AMUcw==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25151655"
Received: from mail-bn7nam10lp2049.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.49])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 13:32:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmKdORYu9GdVQ2ArJBncx3pBXaoqyrz2jjdF6czNvI8Z5EFaqRk1DxXgfk7LhyD/IC5f20gcFaIsrzsFvAsc1rvT3MqpEV0O+qtmhgQ0hHMiRkkzWiF41h4Z1KVc+SvpSCGwgEQDmbI3iNSPa3Z7zZ42+ElJDOO9Zni9qptUyR0EMf8MVptiVN3NY54c5LZDnHec6Gvq42Mg6fnUnfkFVTLYS09OqZvcvpiXYlnmgU5dSPPzq2FYukPMi0s68DdrkXmciFhESFTXVDYWDbWh9l2FAGdaFcq9TcoYjpdGvY5o8I7kP2JjK/VrQDd8558OYa/YlghFD03Ge3kQHwdCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PIbUM1OWvrnYKQJ+zmjIjXd5+yn8tYGtIshlcRRAxU=;
 b=rVjjh8w/Tumgl4BQPRlQV6gI054QYQlGaLvtqTbVCegGsuINP89uAvvtE4MgVW20SQKU1xU4b0cD9JAYufujx6q41GvVRN3yYqU9QuYSQN6QirPFEJSdLUePsocHHzZUllwrKoi6zSIi7i2knbCpXwQFOjcDCUMmu+CAauodEU3zDtNVx8LXZMLeTypmjVof/3aDf0p9dKjkfdOCB6P0uX1mYm4maRx2TCy5WYuzIohAbXuq+CHMV+ibba9DCsSma9uwnih11jWxVbTL38ye14iUMbQrzizEhSPkX54vbmQawje0BTkRmLBHNoIeLqXerAyV2QmphH8A0rT8pD4Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PIbUM1OWvrnYKQJ+zmjIjXd5+yn8tYGtIshlcRRAxU=;
 b=K0iIn59K1gJDuGgawVwfhLNm7XLK/jpfW2W3PoVfRb0bN1AamqUCl7W36vDlttbhUOO7eb5YdyJXjEMj5w36zYCcpjSnoIacX0lMdivrRg6DicFBRvMdlG8M6nwGy5qpylytDF9nQyVcskhvN+eWOiT2gjdrXuxHZHY+DTWxTms=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7568.namprd04.prod.outlook.com (2603:10b6:a03:32b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 05:32:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:32:04 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
Thread-Topic: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
Thread-Index: AQHa9sJ/k6XU2v+xOEigK6atzB+wl7I5ANsA
Date: Mon, 26 Aug 2024 05:32:04 +0000
Message-ID:
 <DM6PR04MB657566FAC186AE1A9698AF5DFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-5-avri.altman@wdc.com>
In-Reply-To: <20240825074141.3171549-5-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7568:EE_
x-ms-office365-filtering-correlation-id: 6e2594e5-240f-45e1-e1bb-08dcc5906b53
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N46+KC2RorewXafreKIc2jLrCiDN6DDnoIQtql6daExPDyJPuS+3a7G9q8Qe?=
 =?us-ascii?Q?zsNzIMHILHZ3EIGslRItYeYCrK8BUx3sTiU9bSMJeeyu+Igii5cFzJF88D8v?=
 =?us-ascii?Q?JzCXGVoZRqIeygOJLu/vyeGMfJk+S0Twg4qa/Wj76fOV1snkETmM+7u7zvz6?=
 =?us-ascii?Q?fjJQzlUFPhOQBb4b6v8zPYJ5htyZHP4A7ZiOrEYUD6NqjMowALGpuaDytkKo?=
 =?us-ascii?Q?hrVKfrsdKTTPski66r6Gc04IB7I8i8iLeksWABij7Jcp69odMaWYEYK/sLNU?=
 =?us-ascii?Q?7j+3u4TGDfte1Xc8HJ+0lOHZN3g2nWmbXkJYS+rL/6f7B//Qpsy17Xr0dbWv?=
 =?us-ascii?Q?c7aE/E5IuoqKZwNwSgq27CcNkaw62Ly6rvtWw/p57wc+uZJFeiGjPXd8wbZZ?=
 =?us-ascii?Q?B1fwwppuJZwjHivDKbZsIZlNV6rpDnN60c1ROcRDmBEEtjyN0GE+HdY6Y6Ae?=
 =?us-ascii?Q?9GzauYn0dmbVfbQ2MC3cNbR8FJzcsxrzQWUupct46EyjHXREND6Qzxpbvvsd?=
 =?us-ascii?Q?NaWEsg917gGN+0WW3iUlXtJfQQoWIJLsJwwgUipmZRV/mPWxCq44deDNs7LL?=
 =?us-ascii?Q?u42FIzvrpRargVdQDHmYws72ucpHCZqlQJQCeFF4rPrLBCHjeRmGLDibROeI?=
 =?us-ascii?Q?lNyyl2aNWI2OicctuILCW628KPFwpIcTbTrJ1AmxMuOAJ58gZrEXC2Bg88K3?=
 =?us-ascii?Q?nKPhfaEThYa5pPf2f7xQDr37mSC8rxAl7y8taIDOq/hp9oa5896yLXcxN7Qr?=
 =?us-ascii?Q?ReQNoT/RtdHp5Z9/rUhxnuvZJIaPR1aOaJA4ACF7ZzGRaeZlP7hYqwRHr6US?=
 =?us-ascii?Q?z7hg6/HX32MTGgrnp4COJienh+zkFfHWDBCdUs1YVR8UaQl60eySbXagaC0B?=
 =?us-ascii?Q?Dw6FF71pWX/Ruj0QbGvPuRKxbFZDlW9RwQJNpOkwzQBvOyMNSLFiRbaGr5Zb?=
 =?us-ascii?Q?imZEKJaPrl9fnTY2NVqiAVqD58mmhPPA5fpPZ6qLPAzQ39YAtxgLpbCpqWKf?=
 =?us-ascii?Q?/q9CD+PPZQz+096OIKjwETDUsCWp5zjieZPkYdGM5exPOGTHhciDDuqaQGqw?=
 =?us-ascii?Q?V7SopoTjHvD6zhsM5rrDFYJi9i2sdW7OPZt9gYYvXf58bUK/Q4Yo0ve4GvWd?=
 =?us-ascii?Q?8o5VaAM25YFlLS7kKThITRKbNMK3L/V52I2YVmf4jP4ZlGbAcE3OYdh79AoO?=
 =?us-ascii?Q?OnrRmgVXRqVnRabFzaqNgEUYtsHALwYjNCVeJT8xk3Ptdn8wSvh2bf4iGq7Z?=
 =?us-ascii?Q?bEUHKElrQLUA5nFVS1/GOnK50/mO4/Ap1FGKM2c9Xy7UD++Vl3wSuQNtbJ4M?=
 =?us-ascii?Q?0daTuDvvg2fCwGEEOMQO2Yc4UaUzdOfKmKkhmB5eoB8IaY635e9BIznn+72U?=
 =?us-ascii?Q?faOMM8dbg+D1LPx64h+NLGeb0M3yDP4kgDJj5HN7C6fikOyI3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UZI7fUdOQkC4LO05K4ALA2fH+ovmB5mOiteiqKF2RFwE/TElKv8gNcVLpDI3?=
 =?us-ascii?Q?aq5wKzpTjX0B1E/rcD9i5umjYvYeefxOGpvAsO1qD6jlCTaKndPhUOFFZ6NH?=
 =?us-ascii?Q?p/+5vWfGVXtIzvcMv+lSzwGmzTtlmT0oIHBwWXWbnil47MrMT+0aFxk01H5Z?=
 =?us-ascii?Q?jQ/q1DOUdF3jl7z1ksZFbSj+rqvMDcYpYArDh6ApxIRzFNj9CjpScWXTuyFd?=
 =?us-ascii?Q?C6JMacqA2tRqge/Kr7Hzp+/3z0Is0HC6Yc/nfKfx1a3zdWDBESmxxy7hRwdB?=
 =?us-ascii?Q?CsWk33ZXT/vGNuAp0LYP2/DTS3UoBNdp1DorQa9QQf5o5lhmFsF5+Ar1MGZB?=
 =?us-ascii?Q?UvsJByb2ufXKB7CdDLeQrifMOm8OWRBIeB+5oWtrVUzsUWqGrVhyZtzxo3MY?=
 =?us-ascii?Q?UUM0Q43E7BJeTrWyHRDm3gzxPvJBgCyxaqF8AfYBDdIA1Tvvtj0ZKoiuh6Kc?=
 =?us-ascii?Q?uVIT7Mt2YcoVcFO8wwNKUoIa1BMOKmN1fcZkeDYY31SpYSVNXoJ/c+jBot2T?=
 =?us-ascii?Q?CrwI+SF6JK838tNN7vROpv3R4vwOq3coSa5VgPid/KA1514WixWQusuBVVo7?=
 =?us-ascii?Q?j0bVyqVhXtyIZJXGOupJQ+xicbMyF7L5DI0uXB1I1N7oGsWm/uVUfmOj2abj?=
 =?us-ascii?Q?Yz//LWZJ60CA4RwNiIBPYDmq7Ae33NtX8AQzWzvc0+jkcVlvNCCTRXBoFbSm?=
 =?us-ascii?Q?9cW2GuZTtZpJ0GFhEuZrD2/VkOcdWxgVzLoB2gc2suQjCpEZ8RItDW9VodzU?=
 =?us-ascii?Q?G5wUN3P17jVigDjKE6JeB2AWI+U0fGn9mYJy5UKF8SZlzzjRvT96pSRibuR6?=
 =?us-ascii?Q?LPKzTJVvGSjkV0uHZjWzxfbpEjLGd3M8sSXTH2R4ElxsVjUUmZn8wll7X4Ss?=
 =?us-ascii?Q?nN5FYv2ETPBkTJFkj3PCLfRmVu7JbnNsA4ndKlb+zlJwar3utd4/Pcy8o0Ii?=
 =?us-ascii?Q?LFHCCfD4maQxLC+rK/k4pPDh93FM09iz95uicKEsDXaJc0vMWhZpqRs9aaPr?=
 =?us-ascii?Q?mVgv8WXw0gUjYVymH+C36feT+f7KGr9YgUHAdAuj9VZMgIuN7aurTCJDvRjS?=
 =?us-ascii?Q?2uz8se3XGdPH7dgbrJ7ovwSKUMKwaH6dVMkkeJA3yX0oy+BlvopLITO5K5Ei?=
 =?us-ascii?Q?EeVOgXzmBYjpz/HRmnCxdYYTIZ79l0OEO5/jal1YRA7RFQfX1i5A9qg2zSbX?=
 =?us-ascii?Q?9xygxeDF4cEhpg9qO/9ws1fe3RsdHrJc3m7EXT5JnWwNqDH9qc5dMSgR0r4i?=
 =?us-ascii?Q?R4nBBOM8sHo1Xxy0aC3T3EF0hE7M29ffuvftcQc8HeC6pbe6Ay9wihZLk13U?=
 =?us-ascii?Q?9rDUdxmddUz66xhSdcIXs3+FZa65XTb0CQegayzEWngRm9fZnokSCAGerX3w?=
 =?us-ascii?Q?q4HAmDXXIkkgTnteGiS943cxkxmhByH5vMStyGi4wiRe1d3xVTAZjfnOwKmD?=
 =?us-ascii?Q?AJ5iisDK7Dfo+Gm+t3OdMEJx/uihnWTdrxcI+lPZVkFkcF1mcud0PiK5O7aG?=
 =?us-ascii?Q?CoOiH/w73nsC6Ps45GpMqnCVjN2AxXQYMErtuaQgZHx5Okgd6NW0/Du6K/mQ?=
 =?us-ascii?Q?UTddFVdKUi9XirDRt9daTzGXTdKcPVPx/6aUkdc0?=
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
	oxulq1XAWv2mZBCMxqX3w3tlNDfOx1S2AcyPOXcs6MmjXlAyKS/fELkg+RABPY9+aXXBaoci7e4/ae3WHF5xuglEGsxXLMD9htDpxGoHxePDhE7w1tBrB+7P/VJwLgCzOmW4KYXwcKECU85/XN+T6t0P2uE77RT1tCIbGkln55HqgIbqRL6MCxgd0NQ40eJCDPAbZo6vm+aA4zrQocUxx+R6rkEMY7/Vgz45YbWEECe8UFWFqhdbKyKuPp3UDD2eJTcDyWm/uucFaHwap0BkNHQaRsTnWCmc6yv+GxiaFXjJSJPXr49V7j+HOyd3dM6n+gPoTiWm/9b7QsE4FuTY+NBL4wx6hkAxKjW4Nvykh1XOGjy/goFlJB0uiL6l9vxGLQCGMrR8bXc2J6PQTB56NIte3nt8wF0rrL8YAGcy2ZiwmKNTsKgocgX8RcEKhtQkQSXK9OUdwMxF0Ry6IP3BoL84iyhQF0VCyTu4fP6sjnyF+7/PagWVtUsTb/lhyRiUnEQYcWw+/etMjNDAEhb33+jRItITA4j/1Gha70HWK4DNOHsEShgFOyv9QZ2/hUH1WlwadS1PmgDs8WuB/R12kkHKkTaMS2Oox19Un06Z1SwvvVMYfAGye92IjUpA22Nj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2594e5-240f-45e1-e1bb-08dcc5906b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 05:32:04.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFeExCYY6cO/kaXLQwePmTSO9ed6DoCDhkpSCZOKNYuQIRja6nJl3f0qauzwUqlqvSFoK+HKO7R/lftUA0AUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7568

> In a multi-block data transfer, CMD23 shall precede CMD22. Prepare CMD22
> in advance as an additional extension of the mrq, to be handle by the hos=
t
> once CMD23 is done.
I am floundering about the close-ended part of this series.
My main concern is an amid stream of fixes & quirks of bogus hw,
that tends to apply extra logic specifically around acmd12 & acmd23.

Unless someone think it's absolutely necessary to be included,
I would like to drop patches 4, 5, and 6.
What do you think?

Thanks,
Avri

>=20
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c |  7 +++++++
>  drivers/mmc/core/core.c  | 18 ++++++++++++++++++
> drivers/mmc/core/queue.h |  1 +  include/linux/mmc/core.h |  1 +
>  4 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 8816b3f0a312..7020a568fb79 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1713,6 +1713,13 @@ static void mmc_blk_rw_rq_prep(struct
> mmc_queue_req *mqrq,
>  			(do_data_tag ? (1 << 29) : 0);
>  		brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>  		brq->mrq.sbc =3D &brq->sbc;
> +
> +		if (mmc_card_ult_capacity(card)) {
> +			brq->ext.opcode =3D SD_ADDR_EXT;
> +			brq->ext.arg =3D (u32)((blk_rq_pos(req) >> 32) & 0x3F);
> +			brq->ext.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +			brq->mrq.ext =3D &brq->ext;
> +		}
>  	} else if (mmc_card_ult_capacity(card)) {
>  		mmc_blk_wait_for_idle(mq, card->host);
>  		mmc_send_ext_addr(card->host, blk_rq_pos(req)); diff --git
> a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> d6c819dd68ed..4808e42d7855 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -184,6 +184,14 @@ void mmc_request_done(struct mmc_host *host,
> struct mmc_request *mrq)
>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>  		}
>=20
> +		if (mrq->ext) {
> +			pr_debug("%s: req done <CMD%u>: %d: %08x %08x
> %08x %08x\n",
> +				 mmc_hostname(host), mrq->ext->opcode,
> +				 mrq->ext->error,
> +				 mrq->ext->resp[0], mrq->ext->resp[1],
> +				 mrq->ext->resp[2], mrq->ext->resp[3]);
> +		}
> +
>  		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x
> %08x\n",
>  			mmc_hostname(host), cmd->opcode, err,
>  			cmd->resp[0], cmd->resp[1],
> @@ -270,6 +278,12 @@ static void mmc_mrq_pr_debug(struct mmc_host
> *host, struct mmc_request *mrq,
>  			 mrq->sbc->arg, mrq->sbc->flags);
>  	}
>=20
> +	if (mrq->ext) {
> +		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
> +			 mmc_hostname(host), mrq->ext->opcode,
> +			 mrq->ext->arg, mrq->ext->flags);
> +	}
> +
>  	if (mrq->cmd) {
>  		pr_debug("%s: starting %sCMD%u arg %08x flags %08x\n",
>  			 mmc_hostname(host), cqe ? "CQE direct " : "", @@ -
> 309,6 +323,10 @@ static int mmc_mrq_prep(struct mmc_host *host, struct
> mmc_request *mrq)
>  		mrq->sbc->error =3D 0;
>  		mrq->sbc->mrq =3D mrq;
>  	}
> +	if (mrq->ext) {
> +		mrq->ext->error =3D 0;
> +		mrq->ext->mrq =3D mrq;
> +	}
>  	if (mrq->data) {
>  		if (mrq->data->blksz > host->max_blk_size ||
>  		    mrq->data->blocks > host->max_blk_count || diff --git
> a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h index
> 1498840a4ea0..7e191d7f0461 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;  struct mmc_blk_request {
>  	struct mmc_request	mrq;
>  	struct mmc_command	sbc;
> +	struct mmc_command	ext;
>  	struct mmc_command	cmd;
>  	struct mmc_command	stop;
>  	struct mmc_data		data;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
> 2c7928a50907..5560e70cb8d4 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -142,6 +142,7 @@ struct mmc_data {
>  struct mmc_host;
>  struct mmc_request {
>  	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for
> multiblock */
> +	struct mmc_command	*ext;		/* SD_ADDR_EXT for SDUC */
>  	struct mmc_command	*cmd;
>  	struct mmc_data		*data;
>  	struct mmc_command	*stop;
> --
> 2.25.1

