Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8399022D7A1
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778995955; cv=fail; b=UxNrLK1rvtH+5XjvNs1EbvWsMiY+spiQSTjt3AtSsLpiBSodAfWgvNLbtys4IcTt/BxwsOaENr6cIjrbYmQoiCazXc7xPKnESvCyWYiCrcWSxZ5daP6Z38jX44SZHVkzGxL3i5vK1raxNo4xhW4HzB+0ePLQ9kuGXLIj8tCswos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778995955; c=relaxed/simple;
	bh=ZFlpdj03ycb6Rc00ImpWvnQjvTUty1wYjAkFQRszZH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjHY4e45tf37Q2rf+VT/8edAC8WG1PtPl4rK5MZV+RmhN+nZoYejOLeLkyuZdiPAIXlUO50xJnXDdc46u1F5aOzb6PklKELkGXyWLkTOPjjRCUi+wPsoRAGguXEjAHtLGDn7jrTghl5xF9trPQhWRgfXYMXUXtVATJ1w+VDS/6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ntgNWnTF; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ntgNWnTF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778995954; x=1810531954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZFlpdj03ycb6Rc00ImpWvnQjvTUty1wYjAkFQRszZH4=;
  b=ntgNWnTFWAcHJWqmix4PYT0lyy6rLyv3cppAVewRfeh0/VSGMPEBkdZZ
   YSCwU7BSvVxdNmPRpI7P5kPTswQBVsIkD/gaOlQjU/rFO9Jh9o2Z+qDEO
   tiJck3uQLtiZTp/zRvK7MIgfVn3sndJ9dArk/ueAuow0x8xsrYrbcMC9U
   TyXcn0KxZK1Y0yRZ83TmhvF0yCiZP/ekc6pbzgxQdpnX/6h1nfkVlqxq/
   0ueXvWG/9n3nrA/BSUF4LQ0fkVeasWxyAzOSwJeNEKzefa1LDEtpYuvCI
   NihkfVrTgZYvpD4NO8ChJbwmcVSFDhA/80pbawTe/Cpzq/C3IVVm+hgQk
   w==;
X-CSE-ConnectionGUID: BBV/2EztTUG/6NqHKDUU7A==
X-CSE-MsgGUID: GbiECyaATZmPu81q16dzVQ==
X-IronPort-RemoteIP: 52.101.57.45
X-IronPort-MID: 22820627
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11011045.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.45])
  by ob1.hc6817-7.iphmx.com with ESMTP; 16 May 2026 22:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8R35ZyWCLzORdgAMBhsxd7Cf+rF2CJpdnOSfCeh1234hyv3bPFJyPumak/5jcqJqY3xBjr+zcgQcI6KFfo1J0+kLiXlZHmMBm0wbpWXpWa3BF11ySnaDPspi4BKzXC/xThE+HntgMJp6ms613ARrngDq2gYccnnuk8yRy2+gmFBPUQktVj2KNIKu5+3rg4sOXRqysVVqBJj6Lv8kN8cLtpcuD+nS8IKOXtcqTvGFe1FNGCNLC73/FAOJIAbxRjcS12VlATw6k+ZORIHe+lEJPs06qsO57YEoE4fgR9/7qb4RYHoHX5NJuF0Mh9l2y167bAti45bhXY8/j6XKP9baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z507Kgc1c6xjFI8Nr9vyX82QJMTRrfYRGjSeCg2sR2Y=;
 b=KUuqLAULNTmaz3sz33LjLy5Y2yrTMWExq+lgcCaKAuGD2nlXxePsRnunqLWrue9gze+2UleKkF+/WwnCeC9phKBReZOEIGTuxpGf2wlLQdfYuWyvMm67hNMOIYeVqMX8MX9FeQsXTqGPGHHYrthWVFQou5dJg+2aqmOiDgLnSN7yZeOGRnpAqY0XBw9gWcz/Kfs5AqFeVPXN6kpZcKjpSYx/Wq9MUo33weevhuiP11Vg4bbs2uo//BlSXI0voqqbdr7fa5s4KACuz1gLE1pYziMFhJm4LLTUYJGnsa8Os8KJgavD16OWrjAZ+BzLtvx7CpX8/3SLo5cy/MDvhYsxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 BY1PR16MB6368.namprd16.prod.outlook.com (2603:10b6:a03:4a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Sun, 17 May
 2026 05:32:30 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 05:32:29 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH v2 3/5] mmc-utils: lsmmc: Accept /dev and /sys/block paths
 for register reads
Thread-Topic: [PATCH v2 3/5] mmc-utils: lsmmc: Accept /dev and /sys/block
 paths for register reads
Thread-Index: AQHc5LMo49+kIHlvkUKPGXh3wqNfr7YRssuA
Date: Sun, 17 May 2026 05:32:29 +0000
Message-ID:
 <DS1PR16MB6753E136C2AF1EBD39984392E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-4-torsteine+linux@gmail.com>
In-Reply-To: <20260515213747.1452692-4-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|BY1PR16MB6368:EE_
x-ms-office365-filtering-correlation-id: eab4d460-5020-4ba2-f8e0-08deb3d5b023
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|38070700021|11063799003|56012099003|22082099003|18002099003|3023799003|4143699003;
x-microsoft-antispam-message-info:
 G0KsS9lPCkiMAFG+NrQMh2yNSgWnm0RRcRYdISuY3rSYnZG5uUCqP/VqJsvdHz4Zhj3t4AqYYF2Tu/vC8Y3vQglSevBJ3d6gor0K+BRNjxS/1UTonNzhrhtdApTTBwutWPlGjShbK4nMXpGwDdv5d4uEt9AvkK+QfE3KDMTcZc/nDZiqKjnDIY82pjc/oV7ncqeAgByP04hTjTD/dcU5tLvgB/qnqEhG1PFXKUzH+ezKU0YeCusA0dEuqDhSyAtIEywKbhlF8AqUz9qh62Sb32OU/HGP5vSqL/3wF8WjkXRWDt6p8QzfMRIRGngxIaE/IJJ/llvAF85ZBM9bHxz0EwMyOkL7jLg0cJXF/+5DQzoPw0hYjFJiX867bcL6g/+YzNlVSHCa1nWXzAt4lDAhUYPRISyNqVlQEKLmi2FdfEJ7NAP9/wnf8USClyUKQ5s2J53R7zBy7Ck5KhYL9L32wsOtTtv1Rb1R5r14dd78boOAtY7+IXbbvfmWBChsK8XUZIugDJ/k+EEIHFEWqq5kyJYL9SbBAW/hvEQ5Jt38FVnVeKWF78YduothjmIlsMlOnSdPbmDMc/OkkWEdQwlqk9jwcllO2bQNnlQ2t5jt5ZeClWoJwRb516yjQY06wQ1LfZZbgZjDSNhhdO+a7oeAm8ROkJ50BLXhhVtUksly5q3wNGpTxVmKApg55UBAlOnjgAPpyf7BQuV+zoMI/CusEZPoKC2+v4Wqivex7UnI6kpexgMvqpfjm0U/y6/rw6Ta
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwkpBAVTj8L1UJLvsKqFNwgu/WeP425oaIIHtQ9GEm7c62uxqhUIpRhk2Dxa?=
 =?us-ascii?Q?/oKLpR5V9eecNlF4n21jhisZAgoRRgb3pIn1qtOEjfEyus8RbwUdeqk8fX9x?=
 =?us-ascii?Q?eijQ7iaO2S8X9XtTEfRWpWWLZtqJoIRAWJ7WIIOEtss1GCWsE8Rhkb3v+/Dt?=
 =?us-ascii?Q?ZWsYfPj34foDI5zQZKBcz/MxY4SoiMTimP9//j1eVwfqAbsAVOGv/RSYfzUy?=
 =?us-ascii?Q?+9t/JOuRN+hsTdL9Xj8gwuffDBXdnucQIAHnxUiKapxEPgZeA4S0Rt337aoV?=
 =?us-ascii?Q?qh1/e5fl+enL+O8CDUdDb+bSde1AD7yHZjiaXBq0CM9h5Yi2GaGZU5Jfwit9?=
 =?us-ascii?Q?gFR/w1LQvohZNN/g6JzdC+S3qmsD4Omzoa8H4YztDaluYPleAeq80PMj24U8?=
 =?us-ascii?Q?jOv/ah1xGSyJbp+32vQzrNgAs3lk3g71TVyntTIzCP2zU1B/RG3Si8/c9kWe?=
 =?us-ascii?Q?QAdw6nEL+OkGD4e45LDe6CqVMj8+l/VPzRzgtzf/9PGVW92D1gRvD4ReYN1j?=
 =?us-ascii?Q?voSKpEnzu8L6JxEx3B/OsgKRzuwYAN4QqLU+WcHf7eqj1ZzbnklPAfzVyzVw?=
 =?us-ascii?Q?L4/zGxvu4M8vRX9ujROb1cw8llFN0q4uEc+co53mC8kbeDB03ndAxiEWK6aI?=
 =?us-ascii?Q?w4qYEelR7MbpWFdHMNpG7oxa8BGyCTlLNqjNeTOqqnRAdouKCFYcZw8ZCtVa?=
 =?us-ascii?Q?uE6rmZWo/rdsQXBynzH9r3JVOpLiyXP5HtHPAjTUES8TqaxI3uocn99sS/82?=
 =?us-ascii?Q?PumjzB1qACaXWaLK+H8OEbERF5W/6srqk/Yv+RajDkv4nNRRZBcxaxercoOR?=
 =?us-ascii?Q?Pb5VP/6bSNzne9uREv9xQCzp93hCtgSnjY32C5V5ZwVuc+lCDN/j197hr5q6?=
 =?us-ascii?Q?rUjvxkw1jbFvnckNdhXNO5t3zVqgSxPugq45nVHNDeD4WDda1EKcCZM/fRwl?=
 =?us-ascii?Q?JS8bNrQ9z9QiiQiN+uphqhXTxFg2AhVtW5yofNMVXdkngGNLuCAXX+usjGh6?=
 =?us-ascii?Q?pC78LM0fo0dpodohjRXcWHV9LC1YFdarzE6UmmC1Z9V98urt+hwuC+fQp9MW?=
 =?us-ascii?Q?tvKW08r4u22W6InSTEvTrllYWZOXisDbZwY4Uwob3O9SjINzJKtt9zdFoa4W?=
 =?us-ascii?Q?vzaZDCvVHwFpVQfXrpZbO83mI4ge/3XhzjbNVSqi4EC28S5nn7ie1hnQksP3?=
 =?us-ascii?Q?AfOe9jw3cdLcbitTHYDOjTEdK3t+u6KKnq8IQLfd1b7s46qGrQ9xPljGOL9r?=
 =?us-ascii?Q?JnFtZAnDWhZGmEiESTbO1jWFWUGVqiDsBVmT5X7Xn1cfjpoMf6z/ASmeQbsb?=
 =?us-ascii?Q?jUMGsr1zSTA3Y6FOKFwru4plbBhtNBrPyItjZ86xClu7TAVbpi2wiH0GR9VA?=
 =?us-ascii?Q?fznUYUXvmB+Nw1p4IqFnXtlT/bEo1qqmAfEYYKhamLQyysX1oCjbuUULr2we?=
 =?us-ascii?Q?TaHP+dr+rOFArs9LwkCTIN3t1FVSIPYJm1X/18dCZteVHTzfgVL6t4VQ7JH4?=
 =?us-ascii?Q?pXZal9rX6zofQ6/rZVy5vxNyp9X2K4zDd4x9xJEiItyFIXyjfZWD3a+gQwyV?=
 =?us-ascii?Q?nqVx4HzisIUGRvV6f1EXrdiQREvN3gaeh3019aArmPtvVkGqp5AOs6xKxMvb?=
 =?us-ascii?Q?pVg2RndNBBgXl5nLZnDIrR1xAEGKczjtKWM2rSIPR7WkolmgrNZnOl8/Z9RE?=
 =?us-ascii?Q?Zy+X9s+NVhDKIi0/MKhKBJzvdkQ2FgWXD6Snal949+XjFeCGUNonJgb4e20b?=
 =?us-ascii?Q?nmmIYFawgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LQmafgvKmUAo6INotYM4oYGhzMhgw/inFKHwtmNSZIXM+NuYtYid2f4o4JzgAvho+3RPoGd29pYY2vHvMu5+H1d+VI5+O6iaFbv70jkly/gg1sTbKLrni0xPEA0fXOyg8ibQIV9hn3BmYs3vgFjrDnyLQfX07QuUpmYX8W7xEgxq6MYDPzx6JrLWQiQhMJCSOBVN8sxoC4lbo2MaOK99YWkgHLcep7rIrNRR6E186B85f0xQHQEBZIA+5GtosWZRt0qBJuZL4dyYQay7Q84Uz6mpWa5GBoJAI6vvCqJ2MWVXqKvWqBncdJUAUCol4btH8uGQwyM1haywvfC3DYPHEg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3iTIjfd0CoLapQzqMAIB/zYkRtJXpyQLVncoUWC7uUa0LMGQlt4oK3XamwpoaYofadX/QRY2AzUQ1qxpYqSVxr9H2LmSb/bnIqS/BsphUEikWQWV6lOvFwIo6L96xRuY3ZpPk1ChJ3VazeRdU1fppo+nYcZ61B3bZxJ7ZzyQsTaxDeI2LqhrcXYnuXdiY/WOrK3SXkoU2SdgPvcj1JWW4qFegJwnIXvedLWfy7ikl4MNLRWWHNaZfuHZ09jcRtNmabFHXsrQXluBxHTds6zcspfQvCWSfJMkckIJqmjWSkoKwLhHc7CHqkiypsXgH3H7LiEDWxTsBNonbps3fLJAr1d/47GO5WELH9gr1UiGDSkY/abvfMzrEyhHFMUpS+QvRKJjJdw8ssU6uLJbnAGWC2wzuyOn8sT5+I6zR+QvnxHFgJU9rcRybHW6imdVZHySJyAiVLssOUOUkLN0TZPFMpgTnTPqODm3JFKR8TCCs4mPb3wkXwJyuhFaB1UsWy14IhUVInqP6PGKyCnqs//Tmjbu+KQ4HSsyjpdB72Ua7SEs3XiSk5m0qR/WJBy2nEurBDnCkuAnA3RCtTFLuMkN6SzFOJjz+U708TLGUewXq/4FcU895LZCcWHljXevfayoV/yxATgp+oiMnS8In0w8Hw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab4d460-5020-4ba2-f8e0-08deb3d5b023
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 05:32:29.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTUzyzQahBK/Wu2PWKDwhSNcNZZNO8l+EiM17kFQ40Nzvkq0deyS3+gcFviHgEmA8FL7O+g1Xo4S9UbgB9AHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR16MB6368

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
Reviewed-by: Avri Altman <avri.altman@sandisk.com>

Minor nit below.

Snip

> +static char *resolve_dev_path(const char *path) {
> +       const char *devname =3D strrchr(path, '/');
> +       char basedev[NAME_MAX + 1];
> +       char syspath[PATH_MAX];
> +       char resolved[PATH_MAX];
> +       char *p, *type;
> +
> +       devname =3D devname ? devname + 1 : path;
> +       if (*devname =3D=3D '\0')
> +               return NULL;
> +
> +       /* strip partition suffix: mmcblk0p1 -> mmcblk0 */
> +       strncpy(basedev, devname, sizeof(basedev) - 1);
> +       basedev[sizeof(basedev) - 1] =3D '\0';
snprintf(basedev, sizeof(basedev), "%s", devname) does the same in one line=
.

Thanks,
Avri
