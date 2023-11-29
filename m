Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fm+yzt9j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PwLUl6Bv"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30412C
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701248442; x=1732784442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8xoVdkoqBpjMSvpmv644sF2ubE1d4lRwee9pd/MZRI=;
  b=Fm+yzt9jOxyIJQIQH1xLRtPM0zPTHBGP6JJ67LOvJJ5Kd2SVFkA8reUY
   W5o1nAVaZrb0Q9Vy7REfxyVQ54Ao26MJk08LXBU9QTw7JwzpYTuKaSaUV
   dzkpVQ9b9Vq162fy2U/AO+XfOSMWNHzWU0DMJMJd5jqxIM1TVQFzmnyZP
   +VZdWODY8Q9GIc96/Ru6wTdaYQ8/lhPtcrodiEd/nmI9jxTjEC2koETng
   gqLuhBo9e+qSpPn3jNT1eNdxu23sNxtEiQpWDSSZgAP3fIV5rhG9WFb4A
   HGwvsKGg4bOW7xiCiBYJdX2fos3bVhqFSF0ED8f+6v2C2zDS19ww4g83K
   Q==;
X-CSE-ConnectionGUID: 7WEZzvL6S+qg8U7TqFcKJA==
X-CSE-MsgGUID: VdeLJ98hSoapN0xMAS//+g==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3455780"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 17:00:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxgF8Eo+S7fsD3M78s1KSyfOPJlhtCV/PP4hY8zJpw70ja5qXapiGFABqx8zB8WEmLSIm+KNyuxXrTL00vya7cFSeiYZNO3kXWQNYksPrRQ55ZEMf6C2FHwsWEDaqqJHNxfFw/igkAh/EWD6zp2jCTm74dYh20PMKSESkRjA3ZdjLFnzKkxk4ItKbrjKm7nR+ZcydrOD5nfpFmy+ouryNnouB1FfJU8/HOBQH9zJxb/0weX3vxyQ7XN3FyfHQgYW67V7ONmF1OtRhj7OTi/RLqp3XJs6krbhhEJGHf+F79L0E8kz5NEsXPG2ZDthPM2SNc1jnXiCQFkf6QYK13C9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8xoVdkoqBpjMSvpmv644sF2ubE1d4lRwee9pd/MZRI=;
 b=DHZCs7BsVIpp+CqScdiSV689BzxXC3W4zwt27XpMp8RC4fdyufhoqQDzkqg797qxCEnZKIg7dC++mzmYL2Jwbt6SA4ix4FJCn2DGtWm6zGjWs/+hEmkt5YtE2kCR0vilc2A94wiUZIcdBvAAeKhsAHvf3ZiteyDccOU6mqqsn7t2ju+FTpO7yk79N/Ypvk/pfmqIPPzTdoUAif+n8g5581RiXmi3+1UgOf1bAX6Q0FFG4MqQS8mtcKHlCfYRKsnNB8h5v9QS+vzpfwqoLsnNCMRY0ZkEkHkBeazKdNinMJZj02u4g91PV/C4qMgfYIRb6vYJjWVTquHJezgzXTUBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8xoVdkoqBpjMSvpmv644sF2ubE1d4lRwee9pd/MZRI=;
 b=PwLUl6BvaeGPdgwON7xRH+ljaVYxY13a0wW6KY0YlWT1a1hPE/FvQeNHopod3uhdrSZdmXD4OAJm1MSBBPPkR0PGlSb3Qh5qnkUCX55fVK97svh6rbAKt6f8hwiS9TGgBdpP21rPf3kCzujThlYkS8FcknYfa/jRYn8RQuDTn44=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB7988.namprd04.prod.outlook.com (2603:10b6:610:f4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Wed, 29 Nov 2023 09:00:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 09:00:37 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH v3] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Topic: [PATCH v3] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Index: AQHaIgrLm7E0JVkRw0yFT3QbRXgxerCQ9hYAgAAKm3A=
Date: Wed, 29 Nov 2023 09:00:37 +0000
Message-ID:
 <DM6PR04MB6575E954CCB1EDD06B2A3720FC83A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231128145421.1592-1-avri.altman@wdc.com>
 <0c78e6f5-e777-47e4-8a26-cc70430ca864@intel.com>
In-Reply-To: <0c78e6f5-e777-47e4-8a26-cc70430ca864@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB7988:EE_
x-ms-office365-filtering-correlation-id: 99d13aba-b4c0-4094-5380-08dbf0b9a7c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wG/uKwca/bZc+aNdBHYI4D8RJgYSZ0OF7paslTHnKpS1Mokf7GcgcWA8YEjenrHluHBMUkRuAF3iTUF4BUhBpo4vJnQt6a88WDYuUy0rybLdJOeAVrUourDLqEvkwviU6e+3th2VdzfVu4ci/C3dJuCY96fBiwLEeenButS4VTAc2euJ1Z37kmuFf6A69kP6zA/r4CWuxrSD9B9aNksqC0zwj8sOa0ZToCchs9zqv7YKPEWCDth1s70FluQ2TuWVk50ZjJ6s+a3oIhysjSNSO5eP2hOSOqc/7Gf5Kacfv7B9rmoqBHjbg2b2/7I2RRUjdcDbudO31c2QX7hfCm7nnAK1Z+URy8c8qKbNLNLgULtVCSrpez8Qxqz8KgZP1a1aVDKB0GXSXvLUY4+YrzZFWiWic1XUlvkUdKCiFfEtccZQg2FQAzTVKN2TDCC462PVBTNI4e1A1YEheGqQLf813oX+Ccsv0KDLw/EHNQOiNV/A44olOMsSbLDL+Kl+WkUx1LCidjkzEN883t0VDyDlJFMOlG+s/wLgaoag4+MM1ChK0hO9BZQSrb4OAb5lTKZXE1/NWN7CSlElv6uImc703NXjfLWZUktzabm6EyqS3Gc42R+2HDnyQnQPZSYLDhFZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38070700009)(26005)(54906003)(66446008)(66476007)(66946007)(66556008)(316002)(76116006)(64756008)(110136005)(2906002)(4326008)(8676002)(52536014)(8936002)(5660300002)(86362001)(7696005)(41300700001)(6506007)(71200400001)(9686003)(33656002)(558084003)(478600001)(82960400001)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1N3OEhWZTZZVE9DYW5LYldtWE4xY1kvUzRvT2Fud09WbnBNU00ybWdBOWxG?=
 =?utf-8?B?eTBsWDg5NmJLRVUyT1g2b3J0eU1icVJra3lGWmJnalZXSGp4TzY0VVlIOVF3?=
 =?utf-8?B?RFQ3ZGtZTThOUDk1YTVSQmxqN0MreE5SNWN1bjN3ZUw2Tm1OcDhsQlZMaWlt?=
 =?utf-8?B?N0NyUyttZVJsN1VHeHBYYTdLRWdneGxnYkVSMlZnNVF0T0NVVXdnd2xrYTNz?=
 =?utf-8?B?Q1k2UDNBcGFxMXYrVGkyY05nRFFKTUQvQWN6RHpZaDN4eXFGdjNtWEwvK2dD?=
 =?utf-8?B?eVo0dU5PVndMUlJYcTMycDc1RHY3NG9OYVB0by9YR28yS2NKazRMZ25oZS9B?=
 =?utf-8?B?VER4K28yS0NCRzhkSktENVRKbmVRSTQycjN4RGpHdCs0Ulh2K2VzdXVVN3I1?=
 =?utf-8?B?WnJ5eExEbUNDVWduS292eW5RVFRjNVhSZnpXdU9hbEZZR0dCd01EcWFSQmVE?=
 =?utf-8?B?ZTlJekozUU9mTCtmY3Y0bTNaeDlqVHM4UUZRWm9BeGt5YklnbWdDRmJtbWV5?=
 =?utf-8?B?MTd2U0x2Tyt4SjlHakIyWDNKdlQyOHpDU0dPakNhTXN0UFFQMENYSVZITlZ4?=
 =?utf-8?B?TGpDTDBXZHlwbHlHd2ltQlpHRzh6bGRLNGJKRTgrajkrejRDTnp4c25ZZ2N0?=
 =?utf-8?B?blZqcFc0RFRjb2lDYzVZOTBEWmdvTGtoSmR5VE0wemhMaE1sVzdJd0xndHBk?=
 =?utf-8?B?VmQreDlsSkZ4dUZ3Uk5hMlJPbWVXNk9TS1hYS3RCY2RUS0pZQUIyZHZ2bll3?=
 =?utf-8?B?L1UxVmppNStsTStETXpJZG1CV3h1aDNZQXROeElGZmJNVXAyd0F2cDZlTDBj?=
 =?utf-8?B?akdPazlIeVZHZmtsYTkxNjlMN2xZR3FVdXIzZHhzcVdiODBjNWhxVVpEcHlC?=
 =?utf-8?B?NDBGcWg3OVk0Z0t1aW8zVVZ4VFFBOFVNWXhOMmdoZjdrZGNqRnRNcTBpY0xY?=
 =?utf-8?B?NTQwQnNnMExBMTR3TVpvbDJvb3hxc2I0Z3pvMEpxTFc2UWUrdElGajROVkRo?=
 =?utf-8?B?Si8yNi9JbHdWQnVXeE5salQ3Yjg0Zk10K2lxSitCaXhkRnhLbHlDaHFCbi9B?=
 =?utf-8?B?OVBGUGtndFFvRkhsaWpoNkJpRjd1bmNJWGxhRm1hK2ZydVBLN3ZyMmp2bEgz?=
 =?utf-8?B?UTUzYzZwUHdQWjJ4SnFPR0dLZFpRQ2wrQk1ZUlJZSTRnOXhRZGhISW1uZUg1?=
 =?utf-8?B?S0N6SFYzTEFTR0p1eUVUQi9NMEFjeFNrL0FaYkhEakNOK3F1NE9ZVjlmOFB2?=
 =?utf-8?B?U3QyOVJIYjVJYnNtdzZ2UnFSYlY1SUkwemN1WjgvcGVYWDF3NXVaNTRidFBu?=
 =?utf-8?B?TGlmRjlkL3V0NHNMdDlSYWU0UXBjRFFRRTZTTXZ0ODBJTHBYOXRnSnN2OVVN?=
 =?utf-8?B?ZUg5QVkvQStadi9PRi9PNEZ2Q2hvY2I1NUhPRUZGS2dPNFZmdkVJeE1XSlhw?=
 =?utf-8?B?eC9pODFsZW1ncFJOVDB2bFZDa251NFhndm03VHVsYXFQREwxNzRoTkxUQ0FD?=
 =?utf-8?B?VkQycUMrc1N5SDdWaWg4RTB2S1Jua3Z0L1c2MW42NHovQlhUNjlTQytTNUFo?=
 =?utf-8?B?RFE5VTFzL1h0ekdHU3o2SnU2elZqV3VmdmprdWwxa0dCc29LSnZNdklRY202?=
 =?utf-8?B?Q0NPSDA1aWJRWWN5YUhDMjdFZ09kaUlXSG9DNlVBU2laWnRuOTVldWkzRjZ3?=
 =?utf-8?B?RDVLcDhiV3Uzb0lZSDFqTTBwYXowQ2V6Rk5RNTJUbklvNDY5Z0VDMGdXa2J4?=
 =?utf-8?B?YnBNRW9mbXF6bHc4NFdyc1JqZExNbGxCeWRGeXVUZWZiM2tzZC8rTzcwZG1D?=
 =?utf-8?B?MkVtK2hQMDJoQ3BkaFNCSUc5eHhKZWh1b0pEZER3RmxBMnlhNkZYVFhnQ2Js?=
 =?utf-8?B?L2FPZ2NGeXpMMXR5NkJxQXh2cllBMlBOQmZCQmtqaUUxOUZEZ2txT3ZwbjZT?=
 =?utf-8?B?N1BzSTNBMDlibXNIdFpOQ3dFWVhZSXNLM0dMblRMaU8zdDQ4YnpJWG9uRmNl?=
 =?utf-8?B?U2JHd24xNkw1a1o1VVRFZ0dLUmZCNXlPcDJUbW5qaXdjcXJsek1PS2paY2RL?=
 =?utf-8?B?VU9Ddm1McXV6K1pVL2hsVnNKZGgyanFQeWEzemhDL2ZKRzB5YnpINHdlN1JV?=
 =?utf-8?Q?8DNMSh2z4naOXDw2cOu8nFSx7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U+zuEelDnD3SBYAkkZSMRqx1jSTm3IPojZoZwEdNNeMk1nU0dusd64B0UNf27Lz/G2lEKWiplEAd53cYJfR25RqT7WvSORSfUvJGGeEQCHyKoKyvvz47WYIE4y//7JAq4+Qp0slZdb/iOyPLEE3wYVrDidyhkxDxeUyOh7+BCGW6vIhx6Oi/qfOmHl+9wRZkDQdUKzie9hg0bFpAZjPoh2ZotpMzN4UGnmGNx+a3Gm9Kb7SQyJ8vAVha54bhbhWQHRLwIHL3ZRzeDyFWY/uXX7cPoeiCfJvN6G5PpMxAFcENXO1dhDdmmorf7eFdbWWp4BtKzYJ9lz046WonQDkyBI+vP4Yf84XggGUT3zvDwGymCvDWXmeCC8cvCVuhg52x8SfdPSDpVyux2X8a696mdHK1BSZ8PzrcQrT87CV2skeOMvn+9znJMfsvScJBXdHZZ+jvf7IUIrGoOQGL7bBZ35PzdibQfnD8XwNkWYmH+xrAWGuXJVWUmEJfWWirfubxUOYekL0daRmYSp43sv0/4JSC+6npD0A9ZfToeb6EarLR2wmVGFUgWne7Qk+6pXUxZcASlOmyVKzHLNInBgeVvh76QL4na7tiUEZS/U2RBzZ6t1/8xiKCmjFukN881M6633e7bIk8hPHa7lJ6KXqvChhAKG1/ea7HAoe3Qioyse4GVjT4XXb63fMCt3lUqvBBtqxkth3Q8ICLo/eedHq4Ij0lSZkhODMaIaXF7JbeUgIE6UTahOT9PDQtp5OPItHDWzuZXU+m+aA/lrknh3+lsGE+ALAojA2QS1UD2nwT09Bxn1oc0Vl0YwOABNPsGCSSrb7TS4bWc0SOo9Z/19CN1zj1WtkxchhXEICo0dNk2VLxJhXBFdXtteQ6CM09eMDlFPCrBOzV+CfxFHstxW9EmA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d13aba-b4c0-4094-5380-08dbf0b9a7c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 09:00:37.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVk535vgdQ/yDFDGrE7XnYmNUbZqXiT3vEsXHykoGvzvntmsY7j8eO0zN30lYQh5d/UQkJfGAFCq0B2o4NtOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7988

PiA+ICsgICAgIGlmIChwcmV2X2lkYXRhKQ0KPiA+ICsgICAgICAgICAgICAgbWVtY3B5KCZwcmV2
X2lkYXRhLT5pYy5yZXNwb25zZSwgc2JjLnJlc3AsDQo+ID4gKyBzaXplb2Yoc2JjLnJlc3ApKTsN
Cj4gDQo+IE5lZWQgdG8gY2hlY2sgc2JjLmVycm9yIGFsc28gaW4gdGhpcyBjYXNlLCBvdGhlcndp
c2UgbG9va3MgZ29vZCB0byBtZS4NClRoYW5rcy4gIFdpbGwgZml4Lg0KDQpUaGFua3MsDQpBdnJp
DQo=
