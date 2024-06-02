Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D43BBCE
	for <linux-mmc@vger.kernel.org>; Sun,  2 Jun 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333208; cv=fail; b=maKQ7p+J+MOZrK8ZQwIBQFB36mvBROBKyoXeFLz12RFT+0DCP0RpZsuSBRoBULSq7XPkXzJvgRE/BWyQ8EPBSXB+bkKxb48Tm93har8gfiM0j4mPdgEzUUWRamDivoU0f1AI+ys9XbZ4u1Dk3v6Sspj5opH9WBsajCYyqSmBHB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333208; c=relaxed/simple;
	bh=Qv7es/TzTEiDkZF2GtsLvoP+OTF8ncGoSwiEgbPSx6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCSRYLuKgV8qLOn8Nlpih4Prpg9NDjIsR1MIocJm8dGr3/w2zajFE9jArh0hf/7w/202j1MA/i2LSUP4XO6i1Jv/Ot3VPJk3g0EYiUWzST7MSlrcLizRSCjzq0/kUyu94AXLcRchgUim23m3EN7FlH3BqdMXLviLDhVE9XPgmic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kvPCNIEs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HHxzpPwP; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kvPCNIEs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HHxzpPwP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717333206; x=1748869206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qv7es/TzTEiDkZF2GtsLvoP+OTF8ncGoSwiEgbPSx6M=;
  b=kvPCNIEsgFHckUK8iDlgQTO5K5mvMGkjaJ1KuCpkA/naMIbqMYb9GvWV
   PR27AzLqdnx+12uXJCQ+Cy3nytQtFozL0IytYbQ3G4dJcT5nFa+dtJCXt
   nK8DpVV7xxcKT3XvQz/ClrApavwv2bTRjKPaiYDeBrtZGrj4g25XsG1eV
   0bad7yYCnUzFTfk5cefRWHWveCCZPe1e9hEHrXB9uWtGxmZ7Ih4h0GboN
   zOBlu3wPVKEndtd1GzFWBxNtXoXpsnoy0HrGHqKW5EZ/Ddb80VxNDJExS
   dMIaCIVFuUy2XY1nCBMVtsu2XJFfmQ2J4M4FY6xAExhtMyizByRx+8LVS
   w==;
X-CSE-ConnectionGUID: Io6A2Z6tQVuQzR7dfV2Opg==
X-CSE-MsgGUID: H5zim+1uTGq6T1Z4b2zRzQ==
X-IronPort-AV: E=Sophos;i="6.08,209,1712592000"; 
   d="scan'208";a="18802087"
Received: from mail-westusazlp17011010.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.10])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2024 21:00:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zofq09Vap4IwbYerkn1nXEBmoIr4+cxA+L48ua9AiAVU1XLxVn76GtuHeN865GMjRAXgnSPvlGG7sfRSUunSO/LSWT2hE40uFEhlZSSZtUcCl0sjjxVbOYzvgtM16X/FurgcQ6W9F6xzgRKdaKVxXECCl1kMbRuIcErFsNLiu64357QObqkN9q9kZHqoe3/QDqzH1RIqUc6lMZRZWGGI2FtkxV5akGFaXlQZGUYrgvyPtzmap+YnnULU1Zc5Q8PYqC3oo6N3iepFYrEgUXbrn16ghuWGM8uUlJ9pxrm6baUMisKz2OyKUeOiU82I/Opt8qFXON3EYO68ri7hD2udpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aDXE7RgEZ1GG1PoUQn6JANjERcDxkt/7Ye1AGD7TNo=;
 b=YY/vRIjgT8mS+jZ3HNs3BPIc0ssT0yOqUc13NiCrczHWsU76k5SBAF6F5BbbHPYJVxQJdLvgKJBmklAZHHGweWOpIWl8N+7ZTFrj3kkQRIxVxjcZ6KBpKlvsiIRkmaxlJCWqCzLj8ES/7XfoRXHNHqnv7049/aiieO1eWnzvvtC4TB0mjUo9JuetAdeJ812tfpDkab0gvMeDBtbmazFOypHgWx6OiQeST41kHC5gVmbMBMmZcZ6PGZ9IVQYolJu35nCrPmV67VMIzeZteY7uuUbctVcBzzCSDqe5cxy22EspPflVexjvQZ2dc0yk5bLmdHZrlAigUD5vdoqNQkGR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aDXE7RgEZ1GG1PoUQn6JANjERcDxkt/7Ye1AGD7TNo=;
 b=HHxzpPwPsKPWmncBzOYNVDsTJXxGdGdiwWglgNTARJGd1aqYo7U7HPGgUN4RD/yr7V3J1aPX0KxNwisW8zdzRCEz72Ri+eAzYHtgLU9L9lk5+aKTrAvnClSGp4onoxTrf9IGodYlAjceT+S/HsEghgc9oRgtYzJwNYU5El0Jjuc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7277.namprd04.prod.outlook.com (2603:10b6:a03:29d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Sun, 2 Jun 2024 12:59:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 12:59:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Index: AQHarRQjZ8lG3T2hpEC0yWy4Na5oXbGzfzGAgACAU9CAAHmbgIAAA71g
Date: Sun, 2 Jun 2024 12:59:58 +0000
Message-ID:
 <DM6PR04MB6575B624ABC7190E84D73D4EFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
 <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
 <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4716f78bbe71f4d8262b16a546393758@danman.eu>
In-Reply-To: <4716f78bbe71f4d8262b16a546393758@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7277:EE_
x-ms-office365-filtering-correlation-id: dac91972-a554-455e-3b10-08dc8303e869
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IXV1NovSKJSsJDh4RjQsdxBjkRriIEdKxk/qvXOnzhx2/bRbjSXZtBASRYsb?=
 =?us-ascii?Q?3bUfkMW53q0xv49h1fKBNWMKiLj36aVoVzKfY7tPb5A29u0GRaod4IM7r8Ol?=
 =?us-ascii?Q?mFqUFymFMETLjwtPcyyNgXSIz74p0h81qWU3z1gyH1l+mK+pr923zdnRMbmv?=
 =?us-ascii?Q?OkfWpjQG8G64HXb5norBJb/vI3gB5qhHSMi2s8bKGIKVoD+Jpe92lxmEhTvI?=
 =?us-ascii?Q?6n+9YsE8HFHzW5n7Vl+CU5QpuHo3hPkZICZRD+/b+UiTojYn/Efad+fRv/Gr?=
 =?us-ascii?Q?Jw8cUNH5v9kT4Pa+Q7blGvF8HplVVSyoibt5bW+9E+OfMJBkn+D2HRW5L5TI?=
 =?us-ascii?Q?7EskWCiok7NYyceWdTESVfddXi1CFx7yVH111PAah+HtLAjd/Q3HB3fC6ai1?=
 =?us-ascii?Q?a4mJ/85Ljv1HIAzr5Ul7jrbWjmrFH9k5QA5kN1pzrai8Mi3s/a2juv09uJN8?=
 =?us-ascii?Q?WtfLaXyqs0Fnw+3HH1bLcUt5P/Fh8Vqp7/W31h+kcj95cltOMrFVWL5ZXVpP?=
 =?us-ascii?Q?dpusuHhmXf6qMkzYbWd7SpJTfEfcm6tHMS/hMK961DpilWbUQwC1WCtjmpL1?=
 =?us-ascii?Q?4l5oMwT/UpSiJ0TfQ8nSH0+enS1zeL8robFglq2WoB6N6bYyTIZiqUMm8H5i?=
 =?us-ascii?Q?F1n1FLFI9I/apsfbAzJyoQDhrrdhVqnjmALkzczTYBNJuMQK4FBM1ijmo5fX?=
 =?us-ascii?Q?wx4naq4DNbx8J+FFrfQz9TZGmcvaGgS2eQiMDNoUGFEStYTCxnE+IYPHNLmx?=
 =?us-ascii?Q?hAcczOZTfbY/OsAqZgiv147k2uBCsvXy7by8XWUNVRdeaB9ZP66/S7to94TN?=
 =?us-ascii?Q?q/XkEYq0NNZBcu08q5liZw2xIBoz5Q8y5bYekDdyT45w9GN1Kc9zhePveoSW?=
 =?us-ascii?Q?+PD465zIUbkkhap/e2n5MFR7WE0U0HVcO1XLgqef+Nx6oy7URsVRHCDMh2vq?=
 =?us-ascii?Q?xqV6vckYgNN54Q7JjUQ90hokdIzmUqF42IL0VKAF0qO/DRaVrAEtMPw9/2p5?=
 =?us-ascii?Q?RT6+p/1oqTglHgzJH5WkJz1bzremFyxu6+nzGX5ZwvRC1TOelZjPaT7nIUgj?=
 =?us-ascii?Q?K7GZ7Vu57XT8fviqZBdLQdL9O52yexUPlWTlgb0q2Lg7TOEtjkai3gOTHR4n?=
 =?us-ascii?Q?4spVXtt37AOrbz/Bp59qcAnLwvCadqxtTlhQJHkB+EJRjB3UsFFnjtWfqB6P?=
 =?us-ascii?Q?oYRF/TcDSOAuoet7Iy8kTdtWAcRQ9CUqrlDUyYa3XmIddLpDyjwVNKQo+sf8?=
 =?us-ascii?Q?eckc3BKxMisqcRPDl3rPGQn8WhnOJt8dfyptxNrf3FhnjDIxF37p//PNQbJA?=
 =?us-ascii?Q?nvzD3TZn08WdLMDR17gbOGa4K+8HeenxXvJMp1k3Oj+fLA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IWAmNjrWAG3SJc7HrJlsecg0c6GtdWbv30ptZQf7yE5SILEuOWd8EBT09k5L?=
 =?us-ascii?Q?bpfEiceUQiGQTGFZCKoyStFcetgsfsWSs1xcAbagpZfArN7zCqQdEGs8S0h6?=
 =?us-ascii?Q?/bC8MiqnltjtCZgC0fohk757DsrPAp7xXad8zfKY+PJKXolqoSwvcnmd6Hxp?=
 =?us-ascii?Q?nj79tqMKQVTImA2PCrhbLxL0FxzN9uHa/nb8XIrbpqsyGrC9X9mPLIASq6TB?=
 =?us-ascii?Q?wJbaJHPjWL3pJBdqRVCWfynpQf31YHhI+OAmav6fh1cHYA9MlowZQZsudLSR?=
 =?us-ascii?Q?f34tfK+ejr43eYNIG9fhcZH54rceUZESDFiUlFFRyHXL4kz4ZAoveUFj8CtO?=
 =?us-ascii?Q?stThYtUF10KjTXVzS53bqNcrIW5gKTUfuN6CFdvdSmIMCMupqBJc4x1e/7iL?=
 =?us-ascii?Q?CyVq7Y+Tyx3NheleqDauq+59hCfpQLAIgVDMqtjfzKLxuawUIMFNjD+nS9oy?=
 =?us-ascii?Q?DOHKnJv8vEOQKbjQqcnjDIK7Rg2hSollqTOBDCQsfQnTB2UlPNxdSujWk4SQ?=
 =?us-ascii?Q?HLB2fa2zJnKicQFz+ukVoxbc4V5FZ81kCsY3tsfcGp1WYNhbjMFDTXZ1UNF9?=
 =?us-ascii?Q?S182xgAT6W6cdFDdTBo4rf6tcXS2nl9DOyems/R0CA+Cd/IkXHHjO9OXAgbq?=
 =?us-ascii?Q?UUx5zP3eeUhoatQcQofuqo9fX/T7SFfMIaC8/avBCKoJwmpAo1jJH+X12gIg?=
 =?us-ascii?Q?I3JOMC04WPS6lM3haDmWx8Pi8a9tNiIB20zM88tTkZ8Nl69eKymcEL25NpxT?=
 =?us-ascii?Q?wTOayX0PErA8xuW7kQggFLSL/dGy0jDZ8mAV2tqLD6RbWOPAw+Xcuo+0vsr0?=
 =?us-ascii?Q?Q9KhRd75HdfpVCw37EkykfF1DhVp4k4c5SIY2BLMTnQ+oIZmatjIm4ai3opN?=
 =?us-ascii?Q?ljBRkXx9hnR9I6QjDWjvZzTqYmt0GK+dN8DTcRA5YTHJHw+62UVTh0bWc9ZC?=
 =?us-ascii?Q?vM9uvcsRlR3Pv0cpd7+ZcdrGq6JExUtkPRUQksUzTXiaXqpkOHsqMa0vl1ns?=
 =?us-ascii?Q?zpHf4onNVL7sbF+6qSR78J1dcS2Jp7rCy7k3iRq0MpXE83eRADaGQWKGSrmO?=
 =?us-ascii?Q?evIJwmJxQfV454tfXBkRg/8Yn477YmjYm5H/2tJE9Ew79NU3+rRVnTGRhksd?=
 =?us-ascii?Q?XuXF2/zniVtj4fQFSQ6TbAEFrBKIweLPGVh8hoGSLWOIVEHQWtfgoK8vWBkV?=
 =?us-ascii?Q?mf5MCnau55LUNik0nRwtQFFUiKgUX0m/f5lh+xikuklh1zu32/JfD0c1H3oy?=
 =?us-ascii?Q?rnH84DmrPlU72G7sAk9E4Fk7UbhZoIAIXlqX7HPTUKw966urV0VpT1BaKPUD?=
 =?us-ascii?Q?SYWahzdWaPJcXJy1/VIlCBdky35VtOCA2WIWCg2uo2X2YOQ4NbS4w+SdfsuQ?=
 =?us-ascii?Q?BzZKqKS7xmTrzynWAxs6d+gedCfQ5VknEuYewYcIZO9HSGJd54vJ34RPmrfh?=
 =?us-ascii?Q?Xb/Q6KyFpMpfLgZc679Z9nzGW05YcxRqQHfTOirVDdvbaqcRzVh/7qTxDAQX?=
 =?us-ascii?Q?fFP0Fb3+s/lgd5D/SzreUs4muaN2bO/nQ86PTkd3Fb4OLeFKh+84HfNI/iF7?=
 =?us-ascii?Q?cajYSAW3JlgZ7D9Qg/ESgpwK2RHHftta4YnwTQGa?=
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
	4aEcTc5Lt2snfXSRgH5g/qWU9rGfGxMiMC5+g2Ph/xcyqOFI2tunlexaMLtJJ1i/dFBXYHixM18xncu+t1C681dUHE7zQtVErh5S1R5JHeyFK899TJFDplIkq+T8dGvcx87IfaD/gGQSD2gi0Drjm6PEwrebt3G9prDiqM6SK3tr1fsxY4fwWT9amLuFPcLH3kxl4wpJ9VJq0S20TaHMjtQfCJE7B2jJ5DczidU4tzR83UXP9d1BxmIZYdYyZpB2YstWPMkHDk8TKAaj5mQz3lOlfqYcHK+JICKxhfKTboVEx9DgBZSHHxAqvooefPC3p8j0+PUwbJSQZ/1b3mKXhMCK5wNRvkkCgagNnyxNPn1ED8TwNUIgv+ReoK0PDTh/cWo+S6KipjIAvEtTDtN4nmHFn4BcaOgwTq1nDna+iNQw7lxxSzGXoPED2cx9g/wMWHJ/abx/JVosVwu9ao/Yf3jzxJCxxIJnI/yKyYRiP1pUdyaHMyo9h6rq8H7Nr8Sjb/s1+2Go7i3O9AMypiCCeB2ns3ievxcwW7lHP/sZ9P09YNFkA2uXYFFLj9X8NQrSsYmK5xKSLk6wn+v+MkvqxhYReOT9g+5belJVQURRGPrxDkN4Sc8lo+RaBqIV3owW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac91972-a554-455e-3b10-08dc8303e869
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 12:59:58.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4MLkkRObw0jXlzyAVjTqSDe+oclHkOcrQxMhvjpxvlkSlVIFmziTzZtAVngV6D+9vPX4ekydWyITN+HqPygeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7277

> Hello Avri,
>=20
> On 2024-06-02 07:26, Avri Altman wrote:
> >> On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
> >> > From: Daniel Kucera <linux-mmc@danman.eu>
> >> >
> >> > Locked card will not reply to SEND_SCR or SD_STATUS commands so it
> >> > was failing to initialize previously. When skipped, the card will
> >> > get initialized and CMD42 can be sent using ioctl to unlock the
> >> > card or remove password protection.
> >> > Until unlocked, all read/write calls will timeout.
> >> >
> >> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> >> > ---
> >> >  drivers/mmc/core/sd.c | 13 ++++++++++++-
> >> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> >> > 1c8148cdd..ae821df7d 100644
> >> > --- a/drivers/mmc/core/sd.c
> >> > +++ b/drivers/mmc/core/sd.c
> >> > @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host,
> >> > struct mmc_card *card,
> >> >       bool reinit)
> >> >  {
> >> >       int err;
> >> > +     u32 card_status;
> >> >
> >> > -     if (!reinit) {
> >> > +     err =3D mmc_send_status(card, &card_status);
> >> > +     if (err){
> >> > +             pr_err("%s: unable to get card status\n", mmc_hostname=
(host));
> >> > +             return err;
> >> > +     }
> >> > +
> >> > +     if (card_status & R1_CARD_IS_LOCKED){
> >> > +             pr_warn("%s: card is locked\n", mmc_hostname(host));
> >> > +     }
> >> > +
> >> > +     if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
> >> >               /*
> >> >                * Fetch SCR from card.
> >> >                */
> >>
> >> Any feedback please?
> > You didn't address my comment from your v1 - Since eMMC & SD shares
> > the very same locking feature (non-COP SD that
> > is) -
> > You should at least explain in your commit log why it isn't an issue
> > for eMMC, If indeed it is not.
>=20
> I'm sorry, I didn't get what you mean by that. I am touching only the sd.=
c code, not
> the mmc.c (where eMMC is initialized, am I correct?).
> How should I address this?
> Should I test with eMMC to SD adaptor? I don't have any currently.
Theoretically, looking in the eMMC spec, a locked eMMC device shouldn't hav=
e any issue returning from power down.
The only flow that is affected is that its not allowed to switch to hs200 i=
n a locked state until unlocked - not to say that it is a problem.
If you can't verify that via code review,  can you test your mmc-utils code=
 on an eMMC platform?

Thanks,
Avri
>=20
> I am sorry if these are stupid questions, I am a layman.
>=20
> >
> > Thanks,
> > Avri
> >
> >>
> >> D.
>=20
> Thank you.
> Daniel.
