Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C1186E56
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jul 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722101192; cv=fail; b=IDG09WljE2ggKXkDQGBdnffC3KuKXO+b8Y3uLA5z+3Fbn4pYp5INyjV+oBzrfc6JtpBQPgXUmidv8Eb2nxfYQdnEAymzm7Jyn3d9NJh03+dnZrSYx2kLLVrxVz6q+YoitDgiin2LAnKXXgSZPX4JpQznw1XNGqg7Sm1LEsBP0xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722101192; c=relaxed/simple;
	bh=fTMI/ElnzWeKDAxWdQgS4c5ic4wUFyhTfMhy6PDbYDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGuLXT5CGWcrlvlVw8HSEItkaEilXSgjMKaC5Ak276pwok4hiUcAtxB6S1Bo/IJqFL8LiV6ko+xxr3eqsBrPGphHEEwKFvpvzZhLbaHNp0JrjjCwUGeNq9/sswjE7lDyhbVuXluJJR3WngpB3SZuq1lyzE83irapkQRLhxqIYcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Mxu55Xif; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e4qc8paG; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mxu55Xif";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e4qc8paG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722101190; x=1753637190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fTMI/ElnzWeKDAxWdQgS4c5ic4wUFyhTfMhy6PDbYDI=;
  b=Mxu55Xif7kIe8vI7dg7td4YZJ8bEM6yq1kcbzQkpZYl154crX/ElEZMg
   d7cKFbEjJfPNzwfJEMje6zXnDHVZwyYd/Xdh8By4VhdXEQM407T5PufwT
   6GmuBM2784KIC4wJ5KWkjcXeLNc6kbkWiRFVZ3FfRvx1cwEunaGw9t8QA
   UpvLgkLv8l5dXNZRNv5LNMDpCQ7vVF9LcQuSDUMXekQZteygzjlQUXJAw
   hdxxkmF+ncx+Eim5rxS0wtybVPj3AIUCucnWKoXhBuSnW+kmC9JqN97gS
   TyTnQYbXZPzGz1fKL/Z18wkc0MtBSfoY2TfYJ4auxfWTSjWiBpV6LgX0Z
   Q==;
X-CSE-ConnectionGUID: 3n3qxdLIRjKG4UzqiTGu6Q==
X-CSE-MsgGUID: IRxqeYO1RdeLdzNxRmDqwA==
X-IronPort-AV: E=Sophos;i="6.09,242,1716220800"; 
   d="scan'208";a="23857762"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 01:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGOOcbEnj3+npMrP6Kt0uFi3nXS64eyWrMdJARwvm/ih0U/NHVBBBkXIZDqjx7LMWrpbGUX1pH6/EqarcKmiQTHL+rSXZZczcjNyKNEQNoFmRhXh/LnYsP5oZoXZTj3nRlsB8hQmJL89rgifbXnZX0fE5ARjllDL6oekaetP/f9GP6CrlLtEZJxgyS7b8D1SddDuMNVnCeUuUqBvIrd61km3b3v3BO6HH26QbeL5skelfAKB+lN7SvShT6xHxUZk4UOrWEIFqw8MvoCdofvTGEoLa9tvnjEbU9Wx3tSmgjKIw93P0VHo0ZGhsWHf9IhL1YdmVFW5iDsSOokfdnEBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fagLBZebEWYK7OBJ7UkeWH+POGQ6SfzXMAfP3djosIk=;
 b=OeXgk9CnyuvyC8bYUWr0deCx4BIO2cPB+tpQcbu1g8qMKXNP5A1qY4IWqNihcdkoF+kiinewgCHKNDSEXE/vs8gR1gUIr1KQX1zTn/cqgCtMMLI0FZnsLAxmKkbxeFzTPqw7RFl74U+fbpaQCqeHjdsNCWu3JpHYJr3Sx2hB09btlx2BuQH9jgupk3zhn+cx/Hvbtsu0YNgDej3Iykuc0JHEIozGMF6kc1cJpMeUzCBGbToMarftE7Lr0EMwbdK9uFh4D0qYpR+0xoxmFrFexFfAXgj1aExxUJyFGHPaMRPERTGNdUavYEpYXV/yVWiekRezYGV71w9se9DIi8WewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fagLBZebEWYK7OBJ7UkeWH+POGQ6SfzXMAfP3djosIk=;
 b=e4qc8paGEX6SkcuYF4bxHItIQHA3Msze0tgi+wadxHEyiyHLVPwHFHkOjGnkILo7XJKcSDPURD98IRu3sxzRy56lL6O5a9V/SyAfnvqwafxmiOzYMdonGv9PJ3Xs7saFALiCevoRbHUWjnwemxUC6TzRJcGY00HR+4ZwzzJvUWM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DS0PR04MB8764.namprd04.prod.outlook.com (2603:10b6:8:12b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.23; Sat, 27 Jul 2024 17:25:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%5]) with mapi id 15.20.7807.026; Sat, 27 Jul 2024
 17:25:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Rudi Heitbaum <rudi@heitbaum.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: create mandir during install
Thread-Topic: [PATCH] mmc-utils: create mandir during install
Thread-Index: AQHa2xSMwg+CX5hZP0ich8wp5tKysrIK3UfQ
Date: Sat, 27 Jul 2024 17:25:19 +0000
Message-ID:
 <DM6PR04MB657518D1B7BAB67695BA2CCCFCB52@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <ZpxwXEKy1bAOCes_@378c8c72e398>
In-Reply-To: <ZpxwXEKy1bAOCes_@378c8c72e398>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DS0PR04MB8764:EE_
x-ms-office365-filtering-correlation-id: 61296e0a-4df7-4cbb-cd15-08dcae611688
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ajbnbOcwFAgeZswLz0WjLgbSx0eBIiubuHfKLipZaxPZK0HjRSMovLmWofHZ?=
 =?us-ascii?Q?BsDn089xvcZY5PheUqUKr2S7+ApSSKV01Rj+CYlfD++21GBr4TYKdxk0/vGa?=
 =?us-ascii?Q?OKeSFdomRVmG8EqvLsghu6Z7MxIIvVqap687MQSVba7jJUw4gk1lKfzx5Gkq?=
 =?us-ascii?Q?yl0fhPakrKoNdD8diXBKDJDPQnlfhP4aVoXtWSUxa+DPXBFMZn8m8SnVKhw2?=
 =?us-ascii?Q?AUvjRAJ9UnDEhhIxkxdUip25yLgpO6kxxXoFHSUqyqcaD0AAOQQXfkRMR8lB?=
 =?us-ascii?Q?26QaRlywWRoAJP99xocq0dq5b8pzS6rlTFjgIc4kYrCXc5Th3+6z8S8Sn5FP?=
 =?us-ascii?Q?zbYGHqK/VP/kyeY1uMTnaWIgnEoVKQZhW8ex1ND/f+/Xn4/nt8bAw4rtDcJV?=
 =?us-ascii?Q?9ibA2GHGV8xkVX6e/UUf0OgE6NHDsuZyRSdAb5cyA046bMR2t9oN6c+BVz/z?=
 =?us-ascii?Q?3V3SigKa04wM6R01FI/f76KX6gcP7NHVAUzHdxAOa3CdLzBQNOqEfA6Bso88?=
 =?us-ascii?Q?8p9HnA+6X5eJ6jHtTtCqwhR8X8+X2BuJJtyhu6VfiYJ8TS2cbUi43wQxP7sE?=
 =?us-ascii?Q?gCMXjaPdnNGIZyqxNEov4nb6Dqy1Z7RumUG0sktDwcnRuahn+lSk0AnLfhW3?=
 =?us-ascii?Q?6NICtwWdLa2CtiTmjK5D0RZ49EmKEsq6L0O2R5zt3tokFDjstnxJvwbHQxLH?=
 =?us-ascii?Q?yq0Qwuoaxvkhqt4FiJJzIX3nGTzMjhJbYV/tUEilob7pdnm/JZHTAw6T8ud7?=
 =?us-ascii?Q?LmdxSGzDo4yH3gXvtvxsRDaBMpkDbdEEvEo7lLLtoqbnaaeMmIh8yKjTA+1B?=
 =?us-ascii?Q?OjxlYsqBzI8EKIEXvK//GSQuGC2RYtKCsaL4q52AfX67Qwk47fJDbfS569/6?=
 =?us-ascii?Q?D7nDiSFkcLXCRld4gMXet4/QQlF+Rt5E22csjSBOk1lOdaIFQfnFYaXbkAbM?=
 =?us-ascii?Q?xxRBCKbbFt7JC8be92dJ0Q/w25q0O2x2fzs4QUo3FurAyfPQmiLBxWMmwSv2?=
 =?us-ascii?Q?40QOkIuR28s8Mpx4X21SvFPeCc/7SIEV/ixiAGii0UE+FemXqTKrlVWumMaY?=
 =?us-ascii?Q?VGDLje/VQVEMq9b/6d8mbmK2V+QoD4XxVmSHAZacLAsGgekNgsc5K30X8yAT?=
 =?us-ascii?Q?wgTJJj45M+x4wVNeZCAwQZR081FxVgi+oje8iia4OC3oyaFnpmmLKZqEypWY?=
 =?us-ascii?Q?VKPgi2lvn3oCgn/tzgWQu+cRH7MteZGw/sZS4sFumoSmhdkRcH7TtYTJyWO1?=
 =?us-ascii?Q?pK42m/OEejB7QXdLPqEDAUmSurLbuak/UZJC1p4TmudRpzBbdKy2yhtM0Tqs?=
 =?us-ascii?Q?+J3O1HuOlns8A8UMb6AydIQUzdEdRPzwUCC9kl1DfqTEGCTretrK2T7bpH+B?=
 =?us-ascii?Q?U5vGWOPFGLVvR4Qoo1zHK4C/dTI4ZQys7KbHjWFqJqzidaiPkg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UEH6QK67Fsi+2fFhUGo5ZiGEMb2T1qRVIcZFne/0ce5CSreM4gXp6/jGmT9h?=
 =?us-ascii?Q?0gfo89fRjLHEHARNB/35qg6K6yT3wYDlc+rcQBGhAh39jy2noWIgPJM+KfYv?=
 =?us-ascii?Q?eFiHxnFwqXqWEjoV/QwR+SfzTZUjB+Sh4qj4vE7RXmrwmioip20FAHMPXQZl?=
 =?us-ascii?Q?6Fafyodir8cJ4yjo4scEu5lLj2jLeLPOCfzgb08Mhz3DxQotXYA1OThM0xj8?=
 =?us-ascii?Q?jkOy4M3J9ltK9MBdS6cMvNyz83213MS9xsM45xkoDkigvLN0of3b2ExmO33f?=
 =?us-ascii?Q?AbTreuudgqukL351FqCj7JBzFo3NZ8P3b9lkhLnESnfAPLPR6eSF97T/35VE?=
 =?us-ascii?Q?J8bbIv2LGumI/dBcwmr+D8amAZMzZcAlT4q8h6ZUvEV6CtuQkfSNvNxtjrGG?=
 =?us-ascii?Q?FivFLMq1Fltxmij+uiP/CBt7/1r4Gnb48+B+0Zizk3BZwsyhuoDp3aD5BrFY?=
 =?us-ascii?Q?xkHS+KCvbT0WmlWcEfGYwz518WyOFZS92rhlY6DHxuUbRsArfSwwTrhMYDh4?=
 =?us-ascii?Q?HBOL4YPDF4dWH/OZV/ovX7DuaVB9m2wl8CqU61oUacLcjlobwGXVtYjYePkX?=
 =?us-ascii?Q?KOLnpF9mMGYGu/LqmDJuy7EijUXVDSMnvsjX+fB89uHREse0QE0AG1yJ6Vjg?=
 =?us-ascii?Q?YwKhF3F2k0MMhym6r7GqU2pWhrvnhlx0tf/3QFqcbXt7ETHPTOHu7pAH4Wa3?=
 =?us-ascii?Q?wMh7ajN07nBKPuEjnTb6Mriwj93ZEcGW0O67SAu/NOS28ybFDVM9k/K7Nb8E?=
 =?us-ascii?Q?gP5UNHuNW83XFEaPG9hrUWyzEfbst6oOdZE8qO8zQ7Z529Iq8Ln0D1UrWC+/?=
 =?us-ascii?Q?BGfcUgfd4dNSrvyGVzrm9BTM48BXK2dAErD/xDxEL8EY3FeTsQexG2j7GbRg?=
 =?us-ascii?Q?P15H21J6RzVuxxyhe1nVvHL/P+IwknTc9N33iZU/3F6IKQ0cSXDK/xWkfQ0L?=
 =?us-ascii?Q?SvlwB5eKL85uiU6kPLQH2Fsn1zKqsYcgQfN8fGSETn4+w5/6D912ZHbk6xjo?=
 =?us-ascii?Q?BpbVPRF18pcUeQvycwjj4A4FX6w2YlXw1uQ14G7vGgRAW32/FB3txWDA5BVQ?=
 =?us-ascii?Q?8SdA5XcozfwxRAIO8h45Iwzlg9aRLmWtwgwD+aFYpUwnIzXCcfnmvUcnbfCj?=
 =?us-ascii?Q?F3RNDYqUPwhf7Icb8WvpK5oqSHgoSjIdU2oYL0HPJBcJIck5umSRna145t0Q?=
 =?us-ascii?Q?+EpRzuXCRmy4HyRC3RDcimqgl1s+C1TsKKiiVkzr+kJa7TSryTfvzH5U/zQa?=
 =?us-ascii?Q?+epVthc9uvoKuzHBRKUdjmDQURNcq2Qhw+N3XSLv9OzAJHQRr2bIL2nJsY5v?=
 =?us-ascii?Q?GO0Z2kWOFs3Ys/moMDo9CPn99IoxMvi9Jw+LoX5iq6A/SFgydZb8tXENyb2B?=
 =?us-ascii?Q?pilaHjt8VP0vo0keY22ksDPJVf2B+yOokSMScm6PWTKcG7h5dZ3HJtrTrKol?=
 =?us-ascii?Q?AfycNMRCmxozFG6Dx9XoxTcqvN0ajPRUcngFKj2LAVcsRUftDaVc3xkafn9w?=
 =?us-ascii?Q?pcX5OJlgtQ1pnMZ9+YFYRphh8589/RUonKywxB1+HBGo6D7CxVSTo9NuzxDP?=
 =?us-ascii?Q?cJ2oJjVk1TYYsxxYpHZpmvQxm+tVja+xZKaLOQXexmS3i1nvAAg5/zdkS2Tf?=
 =?us-ascii?Q?yjcgPl9l4Vm98GDIgHfBFN3pEABJskaXlPsPyu10SGxx?=
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
	p8y2WsIWgwmB7B5u0byTzk0gMtwQYW1cwV29miseryakup3qTyY5eP1e6qqntogpYIHPc68nuj7Zb+9Rj19Z+xyXx0hcsQ1NHaj8VW7ZCOGDPGHkTmBkl8kddopFZ9zhp/WQ3qEqxch82eWykgsNHNI+54EbGyQx9bxSbPu99S3BT0J4HWm6/OKprHSDVGDXko/f1Dar8rh9KzXJJI2Af/RLEfQ3yAdVaFH+4actb7UJCfWo/z3FvtGP0X/ZKR2IGCOqTTm2A37uLoPuKecBXVwc96qAGpoUEGm0TFYr71i1KOAiO6k4uVwroX0Dpe7z1hDCp2OrGWLhN6vwwFhyAchtq5Ex0aij7mhCT6cJHH8AP3icLvEDEgzM9SZnkb32tN6osqaQkI6AlAQ+vD/f38ySWCmeE8zsBkh1/tvjfqHZb/r6JiJgiVPEF8MT4l5Amt9flHrJx47kw3I01eeMoV3T+6JvF3BC8G1QSe+fTBx64pOFGYVKZ+EjZS6ClUIfwlT1gt0R28xB74vkPGFPyrAxqoKSTOuoZNz5Dm5+Y7gLx0vu9iyt4gOyqT17m/1F00ItNwwXtiVVZDdgykHHzGSEhv3pnflQBd7ETGpsUtQsN9gpEuTDvo3e1hpVMwQL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61296e0a-4df7-4cbb-cd15-08dcae611688
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2024 17:25:19.2597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9KgQZy/oAtHQ5Ky7bLr63aoSeQy8OwNxiKOAcAaCDRHuOCyg8tGaf7VdiyE7FFrkwcB+XRxx4ffVF/N/woR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8764

> fixes install faikure when mandir is not already created
                       ^^^^^^  failure=20
>=20
>   install -m 644 mmc.1 /usr/share/man/man1
>   install: cannot create regular file '/usr/share/man/man1': No such file=
 or
> directory
>=20
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Makefile b/Makefile
> index 9e14a5c..06ae0f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -53,6 +53,7 @@ clean:
>  install: $(progs)
>         $(INSTALL) -m755 -d $(DESTDIR)$(bindir)
>         $(INSTALL) $(progs) $(DESTDIR)$(bindir)
> +       $(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
>         $(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
>=20
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
> --
> 2.43.0

