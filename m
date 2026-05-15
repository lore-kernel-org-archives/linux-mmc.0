Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84204921A8
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858773; cv=fail; b=SrBY2VZLWEUZPGPQWsmK/LLX8vMNdXJ8GeiO6eZxQbf/XpGNrXsOn+OOh8tzynOXgB7pseGsF+Fky3g2D5HniQil2Tu7Hj8/wNPXz9SQbMAlg6OiMBhFyB3P3c+t0PArzS58qKiVSKdZuHzkxTahkdCHXEn4Cs8lWt3nMInymQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858773; c=relaxed/simple;
	bh=bkbOKf6Ay6otXCOax8LXZe/MCuBvIzn3b+zKqFjBkSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvNEaphZvVx5U3lLJ7dfz5DY286gwz+y3p1caLh/gGoG+gjYmRE3X3hkuPbQ+q/+HzXO2kIsH5JBKmU15CjGTsAzHwyVQMMPN7sh+yGylzgSJXujy3Dcyvm4MkYY6iZRFvjx7tcB6oEjzM8orlj5IpRjK3yqQazV1/luszdWAME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=UzMl21T0; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="UzMl21T0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778858771; x=1810394771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bkbOKf6Ay6otXCOax8LXZe/MCuBvIzn3b+zKqFjBkSQ=;
  b=UzMl21T0mN6VhEPBitNVjz3QTLNtivEOTGj/I5+Z2AUiCrv9GBm5MCS+
   0z/P2S7Hn83EYT9edDuQvoodi43V1areZ9ZtNYrbBBAq3Tnl5Cdzk6/I+
   wZFqnZuT/i0NZ1mkwLfWqc9IT1ImgTLEtX2OS6pvOF7j2mqdWnbMHtPP7
   QWgkM+NVeOO68OHOnk4nyNlkuvc6dc17Ttw9fDUtcS35adlcWYQQ8BB2g
   XDa5xy6hp4rFFDyUq1sK8E8kG7yJYwYRaEkmjHlMdmqNN2dxJvqZc8Gcg
   u7039y6VW+pYFyhMfXuv6zckWPMNHldu7A+5Ca9jxqHSPaCQUffADcz6h
   w==;
X-CSE-ConnectionGUID: K4C8sbJiTPyCAK0rgkYSWw==
X-CSE-MsgGUID: c87dVO66Ts6NrIYOS2ooMg==
X-IronPort-RemoteIP: 52.101.201.60
X-IronPort-MID: 22420504
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11010060.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.60])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 08:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ4g1a6rJYCZPDOSYp6KKEDGS5e+IMpuYpIZsZKqlxpzVU+mrvRwbM3v+VntsOBAXJsUTUFnMoj0IGWY6bOZcGmPH0WtNpJZPlH0mOZ17ftmPcosAOCnPgcB515cNHFLp3lX9YdxEi78RRG5iz6bW9Lyqzrtox4GFEycabxseF374MkVW5wMXxw22GiL75tYeoEDNNKjJqTmmkPL/k2b+QtmVfeX9WA+jyQtqR4JSglyAqezKCOVOiEg/1G/kKW4SPJ+AFrdQaZLXdj6u4+zlt51Uf0bt5q4Spc0AA6UT2B54isAhIAdvGgWHExliy3fC0DLWLgAcpR9hkUSydzqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EEaW482X5nj+FF5PRpwYB8qCNEXyKhngSJY9JsvF5Q=;
 b=BeRzNsCjg8TLOadRc3BD96a5qGFwcfhwFYSMO0Ve22xyKV1G2jsNllsFFlzCljULHZ7ToXWQ+4Y7V4oNxMQTgad9Oy7ApIdObPLf9I7M1uBB9WwUrnOBM++3xgMAfWpNscdSxzIZmjokLenoPA+z3ao2jpf2kNk8nfAp+oAwgTbOgWjRkzLbFS6DkoYbCvpVHHyvuhUJFujEMNaT6/vUdvNg/ItAQClqYRJjdXCKi5qHDLf6n5ZJmEzVS0PPaXilX8olWUCKNrD7O+ZCpggEiXaV+b3cZfFYEEmBDW08oMGr/z3KAG8hAi2QFu7HQ5IjG/hSFJ/TAOsP0xYFOsA/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CH3PR16MB6515.namprd16.prod.outlook.com (2603:10b6:610:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Fri, 15 May
 2026 15:26:09 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:26:09 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH 2/4] mmc-utils: lsmmc: Accept /dev and /sys/block paths
 for register reads
Thread-Topic: [PATCH 2/4] mmc-utils: lsmmc: Accept /dev and /sys/block paths
 for register reads
Thread-Index: AQHc5EeWDN1dvN1xxEKgI/R4zZH0V7YPMiCA
Date: Fri, 15 May 2026 15:26:09 +0000
Message-ID:
 <DS1PR16MB6753663F7D00E58D22058955E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <20260515083457.3690804-3-torsteine+linux@gmail.com>
In-Reply-To: <20260515083457.3690804-3-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CH3PR16MB6515:EE_
x-ms-office365-filtering-correlation-id: a8ab696f-551f-42ca-c058-08deb2964a21
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|4143699003|55112099003|18002099003|38070700021|17002099007|3023799003|11063799003;
x-microsoft-antispam-message-info:
 5oMCJ7PMaWm1VSkVsRc+BEVaVf/O1klpz4wWl4q2mv+I3g+k8zr9Fwnu7WGhdmuqce22Gn337NohDlMqTvao69PQcEALTjrPjVX58QWrG+udeSkUNj+06r/7uNGxRhi/89fkvcHFLYayYCA7aSICCLtM/q+F1yEfQT9auGqyfXEPqQXKUYTfqFIzHZTpxo7QPC4ksinLgQ5ux7Vw3nBU3gkV3aUD2bXGH3NbKF508TOoJKZWrvCP7gV8dqizbA2BPv4AMg4pCfXnevXAaOUSDqPzruxEoXDD4C6kGTG+cd2BCCCPOaW5fAkkxVJX6hp4/itMqXH2NZwXeMOD4p+MjDlChNWz82Jof2dHS6aXNR4+nxtM8otC/wA5XIeQmwmdOCUztMnwtRt7qC0Njqk05vhUnOMWAR+1UFlpCavUV8fTgqI5WWedZXZ064gq/8QpOX6zeIU5840/Lt+Zkxiuyw2h2pLxB5vWvqHYHowWqVeca53lF4dWiBenPgajYRuFX1iRMSHgHfGXiuNfSIg2sWjznMI2kM5lB1G3krfAcemj4G5hWQ1JjaHrQvnKE9tAYXFVloutxZaAyrgjxzNbiKZgyrkuqaYZn+C4dUbC8j+Pf8Z7h5e/6ZhkkJTW5fA7i41DFWKfsZifg1oHH06lyZu2xOy3wkzB5cS9xAnwjkODzwSY+m2d/7/sNTjDiqtHO/pDtmO7RGPtFDC+sBIBA4Tst0X/WW4YOChlykb1qIy4J6c+dW4ineWwD03SKmuB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(4143699003)(55112099003)(18002099003)(38070700021)(17002099007)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o3htNPU1/PSnEMBM0348L/W3IlUfPEUDGvTTjqnzsM6qMFq3AjXV7+SmQkZq?=
 =?us-ascii?Q?Gx2xyEboS8O1q/nQDBHGgnmlsnV0fTLKnYyWFHCBeNyUljN38GmCNLZ0u2G6?=
 =?us-ascii?Q?nukVSBANhKies5sa45l45MiW5Rzszy2Z3AiUIlJuSvhH5Wn1CiPPGl6/muSh?=
 =?us-ascii?Q?9FX4S23S0Luoji/knItHYNUAqlXXghVJ5Ab4SoAB7eyXyh8zn4wniM5ZOmgJ?=
 =?us-ascii?Q?IBm+bj3Ow1KVTJo7uYtYYuzLJRAT1UdG665z0VsudJSaMbGXMWkQyx9igrj/?=
 =?us-ascii?Q?rG2RfcbMq5RqawsCEUgTcbXfD9l4wAVig6we33C4UXg2m5ph0/JjwdM0DMhd?=
 =?us-ascii?Q?akpJWWV51u+xzImGHwroziRjo/nrl9Vm7Hr50N2gHf8b5YrXAVitHwsEhrdl?=
 =?us-ascii?Q?LToOI2QSdEQNg8/FfJFcwcBu/D+j0N/5BSliEKyxWMqZ9mKgOOmDUxvaaqp/?=
 =?us-ascii?Q?2H2VkA6aY4Qrd8LI/LEVvFcFSdP+c2OWIKH/upcc/auyyrj7mb8kWo/7npnc?=
 =?us-ascii?Q?gXLZ9fXGpg54jP85zmLOhtnpfX7nIitDO5Whx6SZmpbK2mvFAoQ7SdZYhID3?=
 =?us-ascii?Q?c4YJEW3rBOn/CqCVHtsfEdDECuuAP1KcOOiOGarW6v5zYZ5DFfTbj799Ww3/?=
 =?us-ascii?Q?yjjZh7TEMGHPQWs6lTAsSeoPidbiRCnoEg6KTJ64FdGSeK5PwbGKGJdnVWlw?=
 =?us-ascii?Q?d+TR85KOzsRE48sM3v4AFGCQ41Q3uUVV9uqW0oCW2aKSKm547g8by4XTomOV?=
 =?us-ascii?Q?Wxe9oT+JCmd5mPbCTxwqZ/RSOTicgfDwTWc+pP1ZRf9fugLFhzHoHf+gNPFe?=
 =?us-ascii?Q?+z4N4z0kV3vJNW2GwFZcvnXHNuXSMXc2wsKm7+0COh8yJou3PquhjjvjOUaY?=
 =?us-ascii?Q?m5RKa5dV0vzZeQ39tbyg0i5xC2+qG2A1cAk/pYitvV+H113wPBAEvPZjjOTC?=
 =?us-ascii?Q?EUzekHqSd1W9vcyURbcwZi5tXIPHo0fi+H1/e++Ew0R/EUQWqhlAiIQmBXUV?=
 =?us-ascii?Q?lULqMHP6DO9RzxHMZqVLoLCki86SHILZ1nd34ZvqQVJS7c+Q2Go9HI6M8OzN?=
 =?us-ascii?Q?X0vHlYHk+xBoycrZmha9AK7taWa65c87rEpJQTABC3aT7wzqeJ78ht6N5hvi?=
 =?us-ascii?Q?vXjybX336kSfNIBz/yt9/ta+lWAIxEwxp6o/DWM2yDGv+df75PNVpES8c4kp?=
 =?us-ascii?Q?H8dJ1Enq2XtEKTFhB3n50d5pvpnARGku20sWI62ZPMUUVCHRlhIFRnVrGKEk?=
 =?us-ascii?Q?D4LipCMTi3ICQT1lfJO39rprPUAhr29H0BHm8F7439zyM6eBrv0nU9DaQhDY?=
 =?us-ascii?Q?PX/f9ZJi1fjrqqGbCTHsBOez06lXs8w71PzbRaI+t+QyaEJWppzNP0P/V4l3?=
 =?us-ascii?Q?aOfrSzgxIyKaGkODWFxWn1aMRACRWRi5+oP3XRm+75hZiovRw9OzM5/xNLQS?=
 =?us-ascii?Q?27LftQFuhTEq0J3Mtcf8Gwd0x0KNx++c1XEg52PiA5VS3S3kS9j74ekUJdPp?=
 =?us-ascii?Q?SO73eq8QBXjR/uOGvFuU7Gh3C9H/9rfTN2mtzi5t/J4IXe/rDfn7qiky911W?=
 =?us-ascii?Q?7eb2+UhRNpLkWzmxZg1le4xDprc3EG9Rr4Q1UVasWdkkoMD9dCq/KiXseXtg?=
 =?us-ascii?Q?n/vS6QBme6fAJUGqiGPRaj7OAf/hHSJE7U0Wsk7lJoxhZg4aLEQ+vTaH0JJQ?=
 =?us-ascii?Q?NXcpAjWsePpvD2x/5bCrcOa+YOURXrLPdIOUlT1DrzvDik7j1Fd8hIYI4fni?=
 =?us-ascii?Q?eGdyG3qKfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CTcGcbCgxT/4ucaeO97F3oftenf07qVKlJ2w1T5fFtAHAou01fwo2f83t01e03gCgjaq8/pBIPyO/7SET2MlvJXO45GSjvD5l+vBua5M5xPllfhSr78KctfZpXyumJvBu/F+1nVlqlQPyJDs68rooKHbMAc7bGT55818SzFL8comtY9Fp4C8ci7i3ob9B7aTtWnKazD9M1nKsM65Nb4XqDiPKoXZcLdb49ix+xd3vCVeyrcqMnzuXSkjH5/VwDUnaoDo0N2CLHcCUy4ti0IV8U2yRSvS1LvesARAycCBkRUcz6AaVL+Isbun7YVrdoAlODcyzekRQdEuvt8G3r4PvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GJynQIxOcZMd7eiAac1Qtl5+Yij5yu+z42Z629ZXHMR3OxERCO7W2n3j0JZ4eeTOEJC/gDOswHACRq0EuPikPnUKfHOFJiEKETYWDvZWNQh4v3DrCEvDfmA5X1erAzDiaC2FuQV+AgLH21rTTR5ZuxQly2qAkg67Db6gigbt2yn9ahOccdFj9GmMTRzRyTD5QNx0ycwuhnm1VHNM9aYSBjIE0mw5HPrLd5herocCT+tbUXb6RCddFhlWm45kkdPf2Sq8QSe0jWm31DN30hwpszRoa4i8C4Uslbgt2BBFcJ20gnP67RQKjZZnaPV5FzvFJXPJyEy4jCFijAASOb8/AgvQkqPUZZbxFG+maS+sxT66pRF4iwZDZ04rrpcenpIEq6HrL1AXafAf3M37PufDk8NIHcfNm5aXjxs1poLKg3ucPE7YiU1P3SjVNK4xgDbnwyLGLyWGjVVRqScPAYGTNQkY1DI0AaSgEz8nI0PfGeI3qVJTVZvccwqF+LNvdh1a+oWYv0oDG8uGqDcI5SeMWKJ1iFsm5B4T+R6mcW04O351T5HUNlwnNCDC9K7XKhLS+qFmutcLgYYQGOscZXfYazvbT4c8fphb4WnQHWKKSSH6iJAZQn0itcFwPm1prLh+zGVoq2neBXOBHMrm3zJzaw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ab696f-551f-42ca-c058-08deb2964a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 15:26:09.1469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RvsNO9VO11Dz+hOBkY2Lt3PF4pZ53Doww1fosNDUYD0q2dVvx4oj4jBQyM+BwCKzuBDhR59pvA6yjJ/9XQ4QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6515

> Commands like 'cid read' previously required a raw sysfs device path such=
 as
> /sys/bus/mmc/devices/mmc0:0001/. Most users know their block device as
> /dev/mmcblk0 or /sys/block/mmcblk0.
>=20
> Add resolve_dev_path() which follows /sys/class/block/<dev>/device via
> realpath() to reach the canonical sysfs device directory. Paths that star=
t with
> /dev/ or /sys/block/ are resolved automatically in
> do_read_reg() before processing, and the resolved sysfs path is printed s=
o the
> caller can see which device was matched.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  docs/HOWTO.rst | 59 ++++++++++++++++++++++++++++++++++++++++++-------
> -
>  lsmmc.c        | 42 +++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 9 deletions(-)
>=20
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 7a27a50..76214a3 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -35,19 +35,60 @@ Running mmc-utils
>          Set user area write protection.
>=20
>      ``csd read  [-h] [-v] [-b bus_type] [-r register]  <device path>``
> -        Print CSD data from <device path>. The device path should specif=
y the csd
> sysfs file directory.
> -        if [bus_type] is passed (mmc or sd) the [register] content must =
be passed as
> well, and no need for device path.
> -        it is useful for cases we are getting the register value without=
 having the
> actual platform.
> +        Print CSD data from <device path>. The device path may be one of=
 the
> following:
> +          - sysfs device directory
> (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
> +          - device node (/dev/mmcblkN)
> +          - sysfs block device entry (/sys/block/mmcblkN)
> +        /dev/ and /sys/block/ paths are resolved to the sysfs device
> +        directory automatically and the resolved path is printed.
> +        If [-b bus_type] is passed (mmc or sd) the [-r register] content=
 must
> +        be passed as well, and no device path is required. Useful when t=
he
> +        register value is known without access to the actual hardware.
> +
> +        Example::
> +
> +            $ mmc csd read /dev/mmcblk0
> +            sysfs:
> /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
> +            CSD Register: 00000000...
>=20
>      ``cid read <device path>``
> -        Print CID data from <device path>. The device path should specif=
y the cid
> sysfs file directory.
> -        if [bus_type] is passed (mmc or sd) the [register] content must =
be passed as
> well, and no need for device path.
> -        it is useful for cases we are getting the register value without=
 having the
> actual platform.
> +        Print CID data from <device path>. The device path may be one of=
 the
> following:
> +          - sysfs device directory
> (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
> +          - device node (/dev/mmcblkN)
> +          - sysfs block device entry (/sys/block/mmcblkN)
> +        /dev/ and /sys/block/ paths are resolved to the sysfs device
> +        directory automatically and the resolved path is printed.
> +        If [-b bus_type] is passed (mmc or sd) the [-r register] content=
 must
> +        be passed as well, and no device path is required. Useful when t=
he
> +        register value is known without access to the actual hardware.
> +
> +        Example::
> +
> +            $ mmc cid read /dev/mmcblk0
> +            sysfs:
> /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
> +            Manufacturer ID: 0x15
> +            OEM ID: 0x0100
> +            Product name: MAG4FA
> +            Product revision: 1.0
> +            Serial number: 0x1a2b3c4d
> +            Manufacturing date: 01/2021
>=20
>      ``scr read <device path>``
> -        Print SCR data from <device path>. The device path should specif=
y the scr
> sysfs file directory.
> -        if [bus_type] is passed (mmc or sd) the [register] content must =
be passed as
> well, and no need for device path.
> -        it is useful for cases we are getting the register value without=
 having the
> actual platform.
> +        Print SCR data from <device path>. The device path may be one of=
 the
> following:
> +          - sysfs device directory
> (/sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa)
> +          - device node (/dev/mmcblkN)
> +          - sysfs block device entry (/sys/block/mmcblkN)
> +        /dev/ and /sys/block/ paths are resolved to the sysfs device
> +        directory automatically and the resolved path is printed.
> +        If [-b bus_type] is passed (mmc or sd) the [-r register] content=
 must
> +        be passed as well, and no device path is required. Useful when t=
he
> +        register value is known without access to the actual hardware.
> +
> +        Example::
> +
> +            $ mmc scr read /dev/mmcblk1
> +            sysfs:
> /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
> +            SCR Register: 0235800000000000
>=20
>      ``ffu <image name> <device> [chunk-bytes]``
>        Default mode.  Run Field Firmware Update with `<image name>` on
> `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. S=
hould be in
> decimal bytes and sector aligned.
> diff --git a/lsmmc.c b/lsmmc.c
> index 113f371..3149409 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -226,6 +226,33 @@ static const char *get_manufacturer(struct config
> *config, unsigned int manid)
>         return NULL;
>  }
>=20
> +static char *resolve_dev_path(const char *path) {
> +       const char *devname =3D strrchr(path, '/');
> +       char syspath[PATH_MAX];
> +       char *resolved;
Maybe:
char resolved[PATH_MAX]

And at the end:
return strdup(resolved);

> +
> +       devname =3D devname ? devname + 1 : path;
What happens is a partition e.g. /dev/mmcblk0p1 is passed?

> +       if (*devname =3D=3D '\0')
> +               return NULL;
> +
> +       if (snprintf(syspath, sizeof(syspath), "/sys/class/block/%s/devic=
e",
> +                    devname) >=3D PATH_MAX)
> +               return NULL;
> +
> +       resolved =3D malloc(PATH_MAX);
> +       if (!resolved)
> +               return NULL;
> +
> +       if (realpath(syspath, resolved) =3D=3D NULL) {
> +               fprintf(stderr, "Cannot resolve '%s': %s\n", path, strerr=
or(errno));
> +               free(resolved);
> +               return NULL;
> +       }
> +
> +       return resolved;
Shouldn't we validate that the resolved path is actually an MMC/SD device ?
E.g. the sysfs dir has fwrev in it or read the type entry etc.

Thanks,
Avri
> +}
> +
>  /* MMC/SD file parsing functions */
>  static char *read_file(char *name)
>  {
> @@ -2151,6 +2178,21 @@ static int do_read_reg(int argc, char **argv, enum
> REG_TYPE reg)
>         if (ret)
>                 return ret;
>=20
> +       if (cfg.dir &&
> +           (strncmp(cfg.dir, "/dev/", 5) =3D=3D 0 ||
> +            strncmp(cfg.dir, "/sys/block/", 11) =3D=3D 0)) {
> +               char *sysfs =3D resolve_dev_path(cfg.dir);
> +
> +               if (!sysfs) {
> +                       free(cfg.dir);
> +                       return -1;
> +               }
> +
> +               free(cfg.dir);
> +               cfg.dir =3D sysfs;
> +               printf("sysfs: %s\n", cfg.dir);
> +       }
> +
>         if (cfg.dir) {
>                 ret =3D process_dir(&cfg, reg);
>                 free(cfg.dir);
> --
> 2.53.0
>=20

