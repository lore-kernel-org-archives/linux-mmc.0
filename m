Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8430569C
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863135; cv=fail; b=DKnA0p/kmjtqxn9/yh20PFJd1VmHk0B9WEvnOB2bX7FO194s4SdJ1fvjoy0kWOfjS9AYrxcIaEqlY66XqOp6ZxR1zOHsDFPcacGBLFN8Qtwl7YQtE5KqPR1MN7Ko/snUSYHsRuLRafRvgSk5nw+5rVYaQGgqOIRQyrESo+Fs4Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863135; c=relaxed/simple;
	bh=dxUhLbkXhpd6r/f7oOvbfsHFAKjTOGil4n3wpQrTTQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTBWwaEJuIXfV+2yORjbLF/qMuVAo75WMRKBsr0ErifzPHYS7xbyt16bi5ZnwAbxL5XYzAOsky/Mj3UP5pwFK3Y1XXfkVCTZpzdqED0+xEl0/UAp5muqhtyQVoRwZSC2KItoI1mh51KyHzAa0lvde9pkq5o1QUuTF3qswh5lIRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=qui4tRoR; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="qui4tRoR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1778863133; x=1810399133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dxUhLbkXhpd6r/f7oOvbfsHFAKjTOGil4n3wpQrTTQ8=;
  b=qui4tRoRvAfewWu1sNS9JaZ/jjjgxH9qO3CD28rrj1Hb9aThPSDJbygT
   6M+wJQeKXdeOHlCMt4DMWxFJRAaifkXhcMGF2TVZZx+0kNg5qaQba/ixz
   dNIOkKdUPEWgiEhIROk66pkO4pxAHQ2/aUUjK3vq5fMwhj95wgvSWJEMe
   b3ekK27cN7hF8EyFPg7u4qWtbGyK5Y5BenLE5Dsq0nxwHbbHAcUd815k/
   m3/q++hQpaqKdTf+IY8Lp9jv2Kq9DAO2Bc8n4ZOveypxDT8MFdle0jjIM
   ljXWISoeoCNbnXws4FCSb3ceDFceOhu35/OEMvLAvPN1uvyR35FkshrLz
   g==;
X-CSE-ConnectionGUID: 6D+1+8XpQBSsNoXb+9zBQw==
X-CSE-MsgGUID: wPm8pJmIQEaLx+dJhnbNxw==
X-IronPort-RemoteIP: 52.101.43.67
X-IronPort-MID: 22425515
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westusazon11012067.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.67])
  by ob1.hc6817-7.iphmx.com with ESMTP; 15 May 2026 09:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcb2pJ08HjnJy9B2gwk4PIGaB9oUZSl75xMjAqPxvaPpn+6e/K6IVpNEHcUHzTz2VNMU3NuRVvBMT+Lg0jcsISx+HNIPsESWL/pLoqptU+Oqu6ZJhRb5yGHmzBDvCwJgY7N52i7k5nrzrL9Bv7IEIkQml8bmrIp52yC4OR2i3IhWEYZv3LvFHqFyFhtbIkAf7PaQFHf2y9UVKp3cVN/nrtXnwIzHeogWMRRssjrPuFvOA4hTkZgGMPtLHhEFACT7pRlHZzBDaCECanMHkJbzEXNBwqHmG6bRDmP3BP5Ja4I9ryaR1UOCFI7Fb6CXBynhfmvuufOoa1py/VHCDnhWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBbeJTw2oewSKQ5yENTmn/Q6sd+6X16yYf6zM/czo9o=;
 b=hDN1tSrrLWhdUUIGKbGxG2d14RJhwwucLquE2onCFU3uQD3FeQO6mE91AfJOEIowOooq9gC3tN6LUJkbLoMtUbciBK9BegFBOew2fM0oYy1qTItX3Ow2b/oOJdP4ot3rVHbJq6w5AwaqpkJGy5EPhl0GIsc8EPpQDpVjuECSngR/WgtY+rLCSOLlwPC+NWD4ku1sujoHHXfMnhPMVjULv/afRLF+l32Am3Ud7nRfL2Rhh23oP3eI9CoJkMVJPGI8CLMXJp9KKC51W/UcY0gpMR23SX+iWhJyVhGXf/P8blTYeBNEQutC0drqmxjGBjqq8X88s3BKQsfsNYPKGk2xBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 CH3PR16MB6448.namprd16.prod.outlook.com (2603:10b6:610:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Fri, 15 May
 2026 16:38:48 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 16:38:48 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Torstein Eide <torsteine+linux@gmail.com>
Subject: RE: [PATCH 3/4] mmc-utils: lsmmc: Add mmc list command
Thread-Topic: [PATCH 3/4] mmc-utils: lsmmc: Add mmc list command
Thread-Index: AQHc5EY+wi9qym6zdUmzZhNOZx64YrYPNyhw
Date: Fri, 15 May 2026 16:38:48 +0000
Message-ID:
 <DS1PR16MB67536F09AFA69FC335A2F1C4E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <20260515083457.3690804-4-torsteine+linux@gmail.com>
In-Reply-To: <20260515083457.3690804-4-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|CH3PR16MB6448:EE_
x-ms-office365-filtering-correlation-id: f22a9f97-4e32-4a13-ea12-08deb2a070a4
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|17002099007|56012099003|18002099003|3023799003|22082099003|11063799003|55112099003|4143699003;
x-microsoft-antispam-message-info:
 IEpJyLkxWiuetNgT/OGoZXzvABDaz+Q9HvLGALTJPkfRYmJn7Z/T4o11UoM0R3+YD8fw+M53bTeW6AwE9xZqLUTGUG1EYYB8IOGwkg5EkJ/z7Kpj7XODOrmpVUE+7e9jQBjHVKwEBugDHqBgJXbwQJrZXoFVuJd9w5FCBEoSeB+jwhKy3rXApyGbkZLUnViszxpIOl9H7qOqSsC+hZ9MVKUp+tXhEe04CACGayX7ahaGWn/ESv4PeIyv7lTH9CtAYeRhy4OKHxBCqDv4KOBRQiI+Z6ZoAQ9uz3j+IXh6hCeHnQJNgfYO4tn3CRETqebOIyrKSQB6oSINddPaycEV4Y1sEYydP9GKbaqYhs4+cSHhbMTY4zpSobTC9Pl+5cmCHVU8Zv6IpzZaGOPB/Qde0cK89Q7+34SfldIcYiADhOgL1favmI4aLE+bf9Kjd0SDz4r/69CWGhQ1cToBm8GIiEk6eXeGkxsV9w2ryw6BxUr/mLr7kPTdhQh1Ru1+4Yo6KFrCZp+RJqXmrTquhBtMA+dG3/M8fRX1aatgqFmeH4FNC4R28voAMwHLj6Q1++BwPAPd/XiVi+VcCjwACmJpf5QPPXrGtltD4mBAM6sglrd7dxakuWhy/wr5uZ9/bz4CmkMo6lER7kOck8UUwn5dXuHX3HQa9ZO1yzxqxJlQGeJksDTczaewmBHB1jaVaKxy/HiE5u70kvZS1eURmJcESvdp9EJHciN0f1fY3HWzDJ0WUUtReIwNY2oUbyfJckwX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(17002099007)(56012099003)(18002099003)(3023799003)(22082099003)(11063799003)(55112099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?++3fDisOW34/t1BxIf9mtgcCPSr5Pc7Do+yE93XH1/FQCW8LO0WoMx///S6H?=
 =?us-ascii?Q?WjzvE+xrOZJXS8ysXf1R6c1xrsAZFEHcxn20Hgaz2ZJ79Yng2apsr2icUhd0?=
 =?us-ascii?Q?CqI2WpR2s1wqe1zD4CAfXUeqatqNEs2pKLisWkGlRzpRg4CoKcR9RF2HID0i?=
 =?us-ascii?Q?OatWBZOavXlTEyLRvuGczYKBOMnv2Goy7f807EyndEAx7HEu9nAiOP6Jswh3?=
 =?us-ascii?Q?ugVtmcD8fJxjg+lEgs4KmNcpNBqUiupdhrY1yqw4Bn+mzdB9d3JV3UAUTuei?=
 =?us-ascii?Q?wfGDvC4rxo1foN5Dj4gldgOYhaDOKgEBSOSt/+s/eJ/sPQHjONbfQ1BYn/S0?=
 =?us-ascii?Q?e9qxSOkG/V+grNVTmbBRQo72txb7kdQtkJR+PEYxWcPaStXuwPzsBN3ukpg1?=
 =?us-ascii?Q?C41JtpXATa2IMqxiQgAohpBo4DCFFEmFajTcOx/TBX7cCdGelXT7kc8AWbxK?=
 =?us-ascii?Q?GG68O4AVx7XHjvq4CCZCnj9LqkzQuwKpj/6PPVqjXyW7OWUheyrPe6SOnwn/?=
 =?us-ascii?Q?Z0ui7rPT53ie66AuN6ttnpBBciYhDf+TkCAupWmuDSP5NuTDbAua6FOYCxQR?=
 =?us-ascii?Q?qH6nvHZDS3oaEhK+UcGbfgaL3uMIkJKwfxG8Nf3qAO4EgCSVMKVm89Vm/Tn0?=
 =?us-ascii?Q?V7t2ifh8j4si8Up4I9/QXmWEkOAXmoPyuAZMLKvop0ljManFRAv85cDXJQ3X?=
 =?us-ascii?Q?hcE0IbBODnilZ0pBaE4p7ue6X2Bj0H7lpS6ieuWyqvjONDjYWg24Q1CyKsqz?=
 =?us-ascii?Q?SJhO9l0j9SzAqleiAv+22NO04YBctC6CjUY71KHwCnouV495aKeG6kUM/SEL?=
 =?us-ascii?Q?+c9tUQYgZ28xlWjjLRkTWGvtZV/6Oc7xnBLnzM30m0JJoDRD4Qe6Eb6pnjzq?=
 =?us-ascii?Q?dr4+nj29JTHPduc/izESlZbJndAB92psemwfaDd7H1yvRDkAg3lR2qI1lxjf?=
 =?us-ascii?Q?9OabemQ2boJ+DDfIEzS4mSRBup1A0ObCsU85P0PAqDlpFbVEbI9YYtKzvCgl?=
 =?us-ascii?Q?BPw146kOTu8cdta+fxKHPDFxqI3QuSC9DW8A7HuU8l0pC11LKqvvbVuGhSOr?=
 =?us-ascii?Q?XgBOaHt7/bN/ypv4vFFPxNux8jVzve/Nqr4LNkgUfB4wn2IQTkA2GVD0t4zz?=
 =?us-ascii?Q?bg0orjySxpAy123XBx55ckc6vzn6jFXxdf2zrPsN1f56CVbr6MllPRAByNnq?=
 =?us-ascii?Q?GbHh/9PjfE0sCxYooQEt4b32lE7ckaJi6AIiPWPmNC+GnqWDSbBrNvekVRKI?=
 =?us-ascii?Q?i3Dx9WDxgyNfF/7OdQeLAtWtfGSHykWQbC3tO4rP1/nY8VbVYcPeicbUjGbu?=
 =?us-ascii?Q?Eg9yuy9HQL66rOlpAnPM447ZrkHhRQE8CZaJmK3YOe66fX15M4k4qnL1/+ya?=
 =?us-ascii?Q?Bh5fidnNVqIjsJ8igDWECBzfDcIZ34U8HQbWdFVhXO3JEkHSAlqxsQtHHEEH?=
 =?us-ascii?Q?POIZG2bUFX/VpTXGarXIbiZ3S9veNhdxRtjnjCgBiRZje6czDKKFRgbl6hCF?=
 =?us-ascii?Q?SDR42ZS7QKsEEYPeqIGv7kIOHpVJ1GquYVr+tEpRd0sPCHNSTEbgW6QLjCj0?=
 =?us-ascii?Q?Phl29qvx1e0tKgf9LDh9rDVtAYF7RRgdaDwx5q04TSG2dceE40oJ727OIUZr?=
 =?us-ascii?Q?QLHXD5UrUEaH5HS3XwFIDR1CrrcoFNTLnDQKDC9/O5KXOzAuHGOYGdd8cWMe?=
 =?us-ascii?Q?pvk1SxaMmvc0V8RsgzMPn5dE21G0PDlFkCVLp2oERLklLnETf4oEZeWEJXqc?=
 =?us-ascii?Q?zb2RMcXcBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kZAyLs5XAJGFczz12YSeRhcXjsa0yZbWyDNVbeD9rKgm6caw8ngKtmE6lGxHyscn1dGXJy3kJ0+xtJuG8l3h7VvbFg7mlidZAef2WDnm/t0ma9cdYy87YJb70co9DY7BEuXVvYJDA3Rus3VO4jvv8jYdw+lkFD2UgCYmuHu5gN4vWH2TxinPu4OQnf9rhnvUAgMv/nZ8pchJwWvub0qDhPkCK4ybnPYrfUrcej3UjXf4lyHyweDGSgEbXUlASglfCyY0bmQGR4FFUtOVS48xA/f+Fm/NdKeNs3kYFYJn16pK/UUT0BuIuaVhdws3ElLMWTg/oU4rdv9TJnNCHfxETA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xNq7lgkY5IIAqO4CNKW4GhTMuTjS8f5b7NDTEgs+TxEfIrGZxU6gW8WwmMXiND/mU7geT/h3HIypaCte0jVbuXXi5HODAkggAgKoC4piUI9/YmN8q/27ee/ujKgbTQSp54Rwl8oKs2mi5wlZbrFv0pskt2lWZA5RqY6etVj9dZZvMcFwvBBwlWUsDkrQkS9sXpz5CbAkGSi2O8PGIOrOnw6kfwimfcl2Grybvk50Xxc3WN8/mrZ+UYDjjgX9czz0mX99G/RoxAxIYhklD+x/KSjpwztaO2/PNuiuzrUdYtbcY1yD3ILb4cD9DzIXfrfGtBJdD7lhxdy+FbUqKtmDiWE5KFvXgYx2a/Ms32nRKahQcitGgQowSK6pL8rEJJjvjAvQVOoJ8r6yGfKq/pcpLQfHBIsGx89TkzrWW19djqUdIloEyjSUvKQ72OAiPc48hIhVyULrSQuGZMIGYCJ+EYYaU0a5G9VPvv9YWhgfTmkjkh89OegZ2DKtwUTLn9Djtq+VgjBLkqaH00Es/+y7KLyIxKxXeOi8BxqjKDRU/mDVHORN6AHs6gn6bNDVHthFOA4AvR9c+BpmridbfT4gC/OtTxyZOmN9k4gl7e2NoZkrJmq7HD3Eljx5Blf9p6a2/nssmyvt8ungipn3oJXQUg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22a9f97-4e32-4a13-ea12-08deb2a070a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:38:48.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSlAbXb2gqIISIaQgSgePuF9zO0jPyJIV0qJj7euaX7R5q/5qHQEAlGxSs8ES6oEEQLMYO7RIrZ2VAQt5ZBuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6448

> Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves each
> card's sysfs path, and prints a one-line summary per device.
>=20
> find_block_devname() maps a sysfs device path back to its mmcblkN name by
> scanning /sys/class/block/mmcblkN/device symlinks.
>=20
> print_list_entry() parses the CID register and formats a fixed-width tabl=
e row with
> device name, /dev path, bus type, manufacturer, product, revision, serial=
 number,
> and manufacturing date.
>=20
> The header is printed once before the first result. Devices without a rea=
dable cid
> file are skipped silently via access() so unrelated sysfs entries do not =
produce
> spurious error messages.
>=20
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> ---
>  docs/HOWTO.rst |  12 ++++
>  lsmmc.c        | 167 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc.c          |   6 +-
>  mmc_cmds.h     |   1 +
>  4 files changed, 185 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 76214a3..167a153 10064=
4
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -90,6 +90,18 @@ Running mmc-utils
>              sysfs:
> /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
>              SCR Register: 0235800000000000
>=20
> +    ``list``
> +        List all MMC/SD devices present on the system. Output is a table=
 with
> +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
> +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> +
> +        Example::
> +
> +            $ mmc list
> +            DEVICE          DEV            TYPE  MANUFACTURER         PR=
ODUCT    REV
> SERIAL      DATE
> +            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MA=
G4FA     1.0
> 0x1a2b3c4d  2021-jan
> +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP=
32G      8.0
> 0x5e6f7a8b  2020-mar
> +
>      ``ffu <image name> <device> [chunk-bytes]``
>        Default mode.  Run Field Firmware Update with `<image name>` on
> `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. S=
hould be in
> decimal bytes and sector aligned.
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index 3149409..4f378fa 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -253,6 +253,38 @@ static char *resolve_dev_path(const char *path)
>         return resolved;
>  }
>=20
> +static char *find_block_devname(const char *sysfs_devpath) {
> +       DIR *d;
> +       struct dirent *ent;
> +
> +       d =3D opendir("/sys/class/block");
> +       if (!d)
> +               return NULL;
> +
> +       while ((ent =3D readdir(d)) !=3D NULL) {
> +               char linkpath[PATH_MAX];
> +               char resolved[PATH_MAX];
> +
> +               if (strncmp(ent->d_name, "mmcblk", 6) !=3D 0)
> +                       continue;
> +               if (strchr(ent->d_name + 6, 'p'))
> +                       continue;
> +
> +               snprintf(linkpath, sizeof(linkpath),
> +                        "/sys/class/block/%s/device", ent->d_name);
> +               if (realpath(linkpath, resolved) =3D=3D NULL)
> +                       continue;
> +               if (strcmp(resolved, sysfs_devpath) =3D=3D 0) {
> +                       closedir(d);
> +                       return strdup(ent->d_name);
> +               }
> +       }
> +
> +       closedir(d);
> +       return NULL;
> +}
> +
>  /* MMC/SD file parsing functions */
>  static char *read_file(char *name)
>  {
> @@ -2203,6 +2235,141 @@ static int do_read_reg(int argc, char **argv, enu=
m
> REG_TYPE reg)
>         return ret;
>  }
>=20
> +static const char *month_name(unsigned int month) {
> +       static const char *months[] =3D {
> +               "???", "jan", "feb", "mar", "apr", "may", "jun",
> +               "jul", "aug", "sep", "oct", "nov", "dec",
> +       };
Maybe maintain consistency with the month's arrays in print_sd_cid()` / `pr=
int_mmc_cid()`

> +
> +       if (month >=3D ARRAY_SIZE(months))
> +               return "???";
> +
> +       return months[month];
> +}
> +
> +static void print_list_entry(struct config *cfg, const char *devname,
> +                            const char *blkdev, char *cid) {
> +       const char *mfr;
> +       char devnode[32];
> +
> +       snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev :
> + "?");
> +
> +       if (cfg->bus =3D=3D SD) {
> +               unsigned int mid, prv_major, prv_minor, psn, mdt_year;
> +               unsigned int mdt_month, crc;
> +               char oid[3], pnm[6];
> +
> +               parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
> +                         &mid, &oid[0], &pnm[0], &prv_major, &prv_minor,
> +                         &psn, &mdt_year, &mdt_month, &crc);
> +               oid[2] =3D '\0';
> +               pnm[5] =3D '\0';
> +
> +               mfr =3D get_manufacturer(cfg, mid);
> +               printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s=
\n",
> +                      devname, devnode, mfr ? mfr : "Unlisted", pnm,
> +                      prv_major, prv_minor, psn, 2000 + mdt_year,
> +                      month_name(mdt_month));
> +       } else {
> +               unsigned int mid, cbx, oid, prv_major, prv_minor, psn;
> +               unsigned int mdt_year, mdt_month, crc;
> +               char pnm[7];
> +
> +               parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
> +                         &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_min=
or,
> +                         &psn, &mdt_year, &mdt_month, &crc);
> +               pnm[6] =3D '\0';
> +
> +               mfr =3D get_manufacturer(cfg, mid);
> +               printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s=
\n",
> +                      devname, devnode, mfr ? mfr : "Unlisted", pnm,
> +                      prv_major, prv_minor, psn, 1997 + mdt_year,
The existing `print_mmc_cid()` has logic to adjust the base year based on `=
ext_csd_rev` (2013 for rev > 4, 2029 for rev > 8).
See if you can use it as well.

> +                      month_name(mdt_month));
> +       }
> +}
> +
> +int do_list(int nargs, char **argv)
> +{
> +       const char *bus_path =3D "/sys/bus/mmc/devices";
> +       char orig_cwd[PATH_MAX];
> +       DIR *d;
> +       struct dirent *ent;
> +       bool header_printed =3D false;
> +
> +       if (!getcwd(orig_cwd, sizeof(orig_cwd))) {
If you decide to replace getcwd/chdir (comment in patch 1) - use here read_=
file_at as well...

> +               fprintf(stderr, "Cannot get current directory.\n");
> +               return -1;
> +       }
> +
> +       d =3D opendir(bus_path);
> +       if (!d) {
> +               fprintf(stderr, "Cannot open %s\n", bus_path);
> +               return -1;
> +       }
> +
> +       while ((ent =3D readdir(d)) !=3D NULL) {
> +               char devpath[PATH_MAX];
> +               char resolved[PATH_MAX];
> +               char *type, *cid, *blkdev;
> +               struct config cfg =3D {};
re-initializing cfg every iteration is wasteful but harmless - consider mov=
ing it out of the loop.

> +
> +               if (!strchr(ent->d_name, ':'))
> +                       continue;
> +
> +               snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent=
->d_name);
> +               if (realpath(devpath, resolved) =3D=3D NULL)
> +                       continue;
> +
> +               if (chdir(resolved) < 0)
silently skip devices with no diagnostics ?

> +                       continue;
> +
> +               if (access("cid", R_OK) !=3D 0) {
Isn't `read_file()` does `fopen()` which checks the same thing as `access()=
`?

> +                       if (chdir(orig_cwd) < 0)
> +                               break;
> +                       continue;
silently skip devices with no diagnostics ?

> +               }
> +
> +               type =3D read_file("type");
> +               if (!type) {
> +                       if (chdir(orig_cwd) < 0)
> +                               break;
> +                       continue;
> +               }
> +
> +               cid =3D read_file("cid");
> +               if (!cid) {
> +                       free(type);
> +                       if (chdir(orig_cwd) < 0)
> +                               break;
> +                       continue;
> +               }
> +
> +               blkdev =3D find_block_devname(resolved);
> +               cfg.bus =3D strcmp(type, "MMC") ? SD : MMC;
> +               cfg.ids_dir =3D orig_cwd;
> +
> +               if (!header_printed) {
> +                       printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s=
\n",
> +                              "DEVICE", "DEV", "TYPE", "MANUFACTURER", "=
PRODUCT",
> +                              "REV", "SERIAL", "DATE");
> +                       header_printed =3D true;
> +               }
> +
> +               print_list_entry(&cfg, ent->d_name, blkdev, cid);
> +
> +               free(blkdev);
> +               free(cid);
> +               free(type);
> +               if (chdir(orig_cwd) < 0)
We fail here but returns 0?

Thanks,
Avri
> +                       break;
> +       }
> +
> +       closedir(d);
> +       return 0;
> +}
> +
>  int do_read_csd(int argc, char **argv)
>  {
>         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c b/mmc.c i=
ndex
> 077e901..01ad181 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -292,6 +292,11 @@ static struct Command commands[] =3D {
>           "4. The MMC will perform a soft reset, if your system cannot ha=
ndle that do
> not use the boot operation from mmc-utils.\n",
>           NULL
>         },
> +       { do_list, 0,
> +         "list", "\n"
> +               "List all MMC/SD devices with their /dev path and CID inf=
o.",
> +         NULL
> +       },
>         { NULL, 0, NULL, NULL }
>  };
>=20
> @@ -567,4 +572,3 @@ int main(int ac, char **av )
>=20
>         exit(func(nargs, args));
>  }
> -
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 407cbe6..508776c 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);  int do_read_s=
cr(int
> argc, char **argv);  int do_read_cid(int argc, char **argv);  int do_read=
_csd(int
> argc, char **argv);
> +int do_list(int nargs, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);  int do_softreset(int n=
args,
> char **argv);
> --
> 2.53.0
>=20

