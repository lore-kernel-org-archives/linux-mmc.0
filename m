Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98033F9CC
	for <linux-mmc@vger.kernel.org>; Sat, 15 Jun 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718477955; cv=fail; b=ZOVfo7pgo7GuCI1OhxGlLEnj5KPaYfU8o72+hVPNemHORasIQT4rotYibzapUVb/xMOZrG1c2LoGiStZlawrHa+flTCxfn4F7AUmkpwBI+DFhwebZfIuK6BSsaVsgMw+SlnAjYXinAHRIvfoQdB1XKN0MNuyIaEvMNIaAcr78yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718477955; c=relaxed/simple;
	bh=ONJT/jp8mGmBaNp8JLGQ0QVK879y3dWCfPWgYhSPteo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BB3mxAzPwiN3J9ty506BvVaD4zQglJkCYSbkLXUX3O+08NZJstp4t+UwomVyY7FHpfCf5PkY77eqjuNSqpC1EEj2mnTGv8IPmEFM3NzP+xQ6vNYAlckqV3iRqsXLesynWgqSy+VzPrCtwYoYgMqaQfWLIyBDTFG61IpDyk5OzVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ftOfsm6l; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LyrWSrHQ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ftOfsm6l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LyrWSrHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718477953; x=1750013953;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ONJT/jp8mGmBaNp8JLGQ0QVK879y3dWCfPWgYhSPteo=;
  b=ftOfsm6lW15VohpT1oxCmooHM5z51ZSajPWLcMH2Hs61blxdUvnQlhsb
   Iw9qy8uje7bZDEEngdE0E35Anw+QetAAK5G1CPmorHiA2XQd0sk9eAfZS
   /AVLeEAK7Vsi0ICMA78XgA+hXVBg6pUJutIUEHIj9l5m9UJDp5L/EWXRV
   E3Ty6fohfZ+wyIfIQjzNkOVjlIGhkYHRiPBcAmVtGoB9wJRPA0mEo3LVU
   OcUzYA56m3x5ot7EsNU/DlSOwODYVsGVrQDuWbdbYnvt+Xj/ud39JoPcZ
   rS1x446coC62iXpGsxYJ0lwoHb72Vl+fcoLTMpETUGIHSE+7h86DDqFgi
   w==;
X-CSE-ConnectionGUID: EuSLrVTMT1m9nzym/3OaSQ==
X-CSE-MsgGUID: BbkwQKY2QeiRXdmHukhRvA==
X-IronPort-AV: E=Sophos;i="6.08,241,1712592000"; 
   d="scan'208";a="18918920"
Received: from mail-mw2nam10lp2041.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2024 02:59:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0q3lJcNcSmWu+nODq6HxvjJ7FZ3eoazIjXDh/2WObkh81ddVf0g9jega/bNNUEsPc0ILEv5lOx0ejrjWW2SJ5JAA+NGPCV5UVcw2bunu+hp5+Va5zw4/MNWy2muXBnmcoPCc5QzKylHvJtP2XTteSe9ZXTHf9Hh2Ad6OuxVO4KhICUwyIVJ7K7j7vQ9jrNA9n0n4lFj03KeUOGEZeXtT0A8ifUOa+/dt8hDwAJR2U9RV62vOh98cOuBeK4yFuwnnzT69MZKvf+06q15m5MomMW//SDU2yNnCpuVnRPwHYbaGgDA9trbQtMNdOBp+qYTGheNFTeX67Ln3NgL4UykGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONJT/jp8mGmBaNp8JLGQ0QVK879y3dWCfPWgYhSPteo=;
 b=I5EWl/tp/rpdigTB3LNnSCbhS6viAuS9LsvNslTYxKGHFv0Spsb3Huplbbxf4/ejMK2Wcta6Do3VBX5xm6JklRZgolKw1t2UOpaqEOuCrE2yVBZd4Gp0XvjFVdqbLkfiFIxopppFZbo+ch6iR+OYxeeHsV2Pb5aTdRXxQYHuAQKgzn7zJE+bC9snnaNc9GCbESHTecjjDIYd2n5wEU6/vCD63aqbwD+HkenwTvjNZBJqZ6yzGNsHt6W791q4SMaspFGCGFsOJN5omKvo/h9kpOQqU1AotzojwBPkmDQTxAv0u2JYzM2EUOVcq2mtvDP7mKsjOOSO6luQxk/w7QpwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONJT/jp8mGmBaNp8JLGQ0QVK879y3dWCfPWgYhSPteo=;
 b=LyrWSrHQACjJJ7YXmLBOI15AeHAJDIGB4bnfMewbX0lbEgD9Mxh7Kce9uapb6SIoG6qXP+HA0JkwBdFg7W61L1OSvIFJPlMYNKmZZE8Y/5d/sEmdDGWVO8sY1W87WPu4jZXlVviFSQ4pMS2wTlyPoV/OVZwjAaJC2tFDXFy6z/w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6658.namprd04.prod.outlook.com (2603:10b6:a03:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sat, 15 Jun
 2024 18:59:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 18:59:03 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, "linux-mmc@danman.eu"
	<linux-mmc@danman.eu>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Topic: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Index: AQHas4fsA4nl8i8nIEOrNn71ENxcObG79vmQgA1NftA=
Date: Sat, 15 Jun 2024 18:59:03 +0000
Message-ID:
 <DM6PR04MB6575AA37CBBB9993DE881F26FCC32@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240531182517.929498-1-linux-mmc@danman.eu>
 <DM6PR04MB65757FCA620263AF74F120A3FCFB2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB65757FCA620263AF74F120A3FCFB2@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6658:EE_
x-ms-office365-filtering-correlation-id: 389e9f2f-0e0b-41c6-4ca7-08dc8d6d3992
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AKgbjSiG73AZ9DlSlESZawKpCIn8XvBHhdEsdjV9Hp7QiSRTh4iEqyOFnUT6?=
 =?us-ascii?Q?5EMci5BLpJ4y2ugEQmgc1zqedK9ql0/4wxpizToF5E+y90I1Nv/Rcn0ZpT4e?=
 =?us-ascii?Q?KAGwuMSBekSWfMIwz6P/mLvMo6Xy/xYCYzyDmqcOby+tl/fyCe/rZhiAH4An?=
 =?us-ascii?Q?BIlLw01P2wysnUaA5lh58DqFP/zL2NP+sOi+EbYJlpnLs5LQWlH5nd5HuByI?=
 =?us-ascii?Q?EvHX2eakDBG4hNU2IMg7urc215WfMQQKpfFG169l/vgwS4MPI66a9vK7Zv2J?=
 =?us-ascii?Q?iqkhZXfsKZdMYUV7IH1EXY/EDZFY0v5b6FO8DGyc9mnfvnCX/1djlddwy15S?=
 =?us-ascii?Q?/mCfcMkme5QJHwzg6HlroNzDPzqlXlDpffaIboQFXUWwPj2NU5nENVV/YCkg?=
 =?us-ascii?Q?Zs5Rm8pCt3eHRg1spT3B9TyS+SjIDw/BVi+SWHm606guB41+XZSqlDHp8Fs9?=
 =?us-ascii?Q?CQnH4tWScJRzzF63vhYuZ4IQndX8HnERFVmkEWyx/pGGgy5gqIEW3m0bRCLx?=
 =?us-ascii?Q?GtoHp13DQP7sJcwQJlnPY67xRzycHfp1GXHDshNGuok9/FzoFSqwwbk7XduE?=
 =?us-ascii?Q?0sFG64wgLzDRxh+yOIXjcwT1QL5mVnbeL1j8MX5K7NHUJGWg9fHvw9unIOqC?=
 =?us-ascii?Q?EVrJceo95B51sNhWatTTy4wmwSIhtTRNEXt4fAP6qLN4jvQtwV6+2Etq6cpH?=
 =?us-ascii?Q?XNWaRpqqM22VE20c8PJrNVo0i8Ypb2yyXpE2RjBb8/IHq7R1xg/xa3Bxbq5e?=
 =?us-ascii?Q?MMnRsDTPPi9RcjXGQFghR2qiimn0YrBqCd810hB2AAOav+tfHrzB3B5xmIiu?=
 =?us-ascii?Q?6SYWTLjdm5wKZrCh6mDLDGQQgVTnhSd//oJ58vJby/ImxCLZuIKbLi2Qqk2c?=
 =?us-ascii?Q?xsoKe+XdG6cZ5S02fKR+y9Bf0DtEPsmr3+v3Zr5HQUABrKXj85+fXAuzMynG?=
 =?us-ascii?Q?gGfQXVqJiUlcQmCaPmFqIgcB+1YiDY/MTG91KjUcUCXUA/WyNevxLeo3F0zY?=
 =?us-ascii?Q?bdYfS1WxNgTIhqvhXNnC/anJAafcRz7KdtHkalJZ3nuslIK7MEICnhotTw67?=
 =?us-ascii?Q?XDxuMCNrgH1cWT4xl2l+T9k9glkMdV85wuyZX6cqanskC9Dt/dXVM5PubSWl?=
 =?us-ascii?Q?q3XCMDHQNuQ6CojsSh7cN8dgQqWXWqwovbJPtp5KnjeOtDWkl+QoKdqWHI3h?=
 =?us-ascii?Q?hDxUxgsHSjdcKUptObN72+QbMMslgnA2ZWkyidwnQ7pO2KwlLR0TT2tGfLnz?=
 =?us-ascii?Q?iMX2k4B+hpg3lld33Aw43kA/4AaUaE2eniRg/VHoXRKJq715og4JgQeD8gaT?=
 =?us-ascii?Q?ZvuTVDHvVFCcxeZ1bwGQGxLpY5cTCHppT3tQxeYagZPDAoggnRnS0ct48p+5?=
 =?us-ascii?Q?a/PqTgU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YzlE94MPjAv2q9cQZUAvO9nJW7xbU2v5va77+edcSCgMGQC2VMo/b5PH80AG?=
 =?us-ascii?Q?jwxG+7usVToxS9p9kfr9dBx+dfTZu/c+W4sgI1Hah1AXkZh8Zgj7oeCaE1gp?=
 =?us-ascii?Q?e++h2/MYvrj6Fkl99KTbADmukk2i7IMkY55yfhdmyZ0AceX+uidrdRdZsymX?=
 =?us-ascii?Q?EK+kHEQD8TgmSfxMGVhF4gtjTNYfk9FJerqfFRTT4z16z+fPoilQl6fq31US?=
 =?us-ascii?Q?/UVkVGK0B5l7DV7GttyvpEjJQvdwt3f6kPuHxYGTvkIDvUnib8b+FxlEPOCC?=
 =?us-ascii?Q?oU44CEil4dM26Lzh6Gxh5zcKHhaPZSzgkU3ODLsszS+1p2cwhD3hTHIWBs+q?=
 =?us-ascii?Q?AGdRbtg52D8oaRvhHeQRZKhO9rGTQtHOYmdDt61pudJvT/4KlKiN+GkTh2sC?=
 =?us-ascii?Q?eoyRnMPbNohcbgO7Zlyrs5yUyHon3A7HjWXriCpdpk0ulwLJbIavnV3euLUZ?=
 =?us-ascii?Q?ixL5niuWtmK1h7AtFP0LzUfDvhwRNrAVmKuPVmNdJXHcCnrjt4eQwbDaRMW7?=
 =?us-ascii?Q?+cjIh3ht80GUM90WkU//vNHIGXdtVrZi6gNPkEZUG+FOMuKSvDXl6ARp07Ty?=
 =?us-ascii?Q?BxCpWnryrnOD7za8pg+QPGcver3gDxmC7FOZR17yyJKpoFA4qNUQUQG0NsPU?=
 =?us-ascii?Q?Gczkp87HzA++7nIsCkkELVUXC02zKlRDclcI6urxxXVmsEOKbR9vPsuSBaRR?=
 =?us-ascii?Q?S3KUXa288I4nFnt2QqBI/4aD5tbraLqlkvBElNKzEAd/JUnejg0dKx+oe226?=
 =?us-ascii?Q?XZIGHULoQrikiOul97kKxXk0Ns8xczDR4MsL86w21Y8QhmgFQBTD8FXTNyCV?=
 =?us-ascii?Q?3zlA2wxtJWcCDERhpl+xRQRM5lahSvZP3N1/l8v78Yg/JbkUx5+H7/s9NrrU?=
 =?us-ascii?Q?1lK7uWspe5tguJYYNWgU2OeEqaQHlo8DA5jnXjwsIVCq/RCT7IC0PKCdWRjl?=
 =?us-ascii?Q?b/9oUp81NWYzhpLasKiVR/n2FSVZ2e6FmrUQQjF3Ht7L54Jy8v7kRLQJSd5c?=
 =?us-ascii?Q?dhXXvvrGMO7CnugC8VRprZ4T0MM90VgM8Rn7DNvpWohXGP5nc/TfPIi8eBvf?=
 =?us-ascii?Q?nsAOoEdWXtBiYe9YN8+y9uJ+MkwOv4+wWme8z4UE81YhmCss3tTeOgumXxmZ?=
 =?us-ascii?Q?pY4p/zcEFXe0Jq2On6o7anddI2Tbcc9M5q7LAhAUZur5Oga8/0bwktwO0Lal?=
 =?us-ascii?Q?6Hr3axsqcwfvuZvzAB7hnE+gztD0Wb6wGKKKAyuYzpYX/zt5ohBXbTfZwqsW?=
 =?us-ascii?Q?sJA404HI2I8Xp76Xg08pNBzRDVAvW3YrSWLlH2paQuzfWq9uCmvKqlZXCOhY?=
 =?us-ascii?Q?sjtvrrhcWs/zqzRP6dVDSGC1f7MTfGXjyMFovJgKQ7/xJK8yAaR1AoqMDRRZ?=
 =?us-ascii?Q?E40WpYBOHa9r76na6IByZW3I2rFwvaSzX6ahuroakbR4GmgKv6qofWF4q76n?=
 =?us-ascii?Q?baY5R7E7NtrB3rTUtJ5aTHiwFqioW7hUSTJsCqsaAQQUEZkB4wxy8Y0TDdF6?=
 =?us-ascii?Q?CFJKzwmBfW7W/+IwXHBulrzmb2ugnVoR3M/zN484bLl/WZEVichjx7T2Ua77?=
 =?us-ascii?Q?DhDU2C4Da4yn2qGmWTTkhuZsuD58g5UuE+3szTA6UcFl5Wc+TbdFt1Ht0U6h?=
 =?us-ascii?Q?xzOveqPQjQUIMOZzQuWMOXGzh1JhNDkRLs0YbScRemUq?=
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
	f9vAlaCiMFCpFA6nhojz/SBD4dJcTo9HJtz9ChS1PU1MgHZMUv0LyF8NDQ6fpcUMHmX2UXabG5SqShi5SKn6UlGirMLrEVn+AqJwO0fsK/IdyV95qWr2/iGSMUUo17g3f785uyLd7327ZfjA8SsDaWjmrqD2cUCTl89SPWw1VtfeS/zEoD8kiaUAkrZoiNyVrpMwrvtihZDQoKegJobSk9eHh2mQeJzvgYZ2GTCixs0FAtmyPFIO/mxk6hUTF9bs0vgkvkPpa0Lp5t2xVPy3M8TWM4nT36shii0zrJPPQ0qSs5gR6vfCQ3mcd3f5/vsaYNAdRsZwXYdVwhg7L8Cf0aAKM+ETo+DfXvEVTVEO17AnDnEU94QePKM5pCDPKrmuOPBYYFavyhAy8zTbNMHMnrDlDfZ9r/AH1a630nnaMF4pc/Fi4K9qFTtRYXPdEBQyq/qo0ybs9h7UT4aBRFKVLjEIKzlM16eMSG5qYaojRfPyy53nfhJnc45S5RKkXtI1xx7G94qYY4ENVBYiGZF7h4w4K18au/dqd6bK7/AA+pT9SaZB9ykZBIVl2yES0PxqcnqRMejwRxI8bpdKSPtV87hPEF38IYZAwJVOWOJaUWZ8yyoDJY8ljwpWixEp+zJZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e9f2f-0e0b-41c6-4ca7-08dc8d6d3992
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 18:59:03.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wDZ2tZiyIBcAAsLrLqZvTXiKOk1dYT4LzAYoukvAdfht2sDz76hvQIblbZPu9jjc8ZHwYR2OFGUnSmmcuny8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6658

> Can the above be eliminated by using parse_bin() instead?
I guess not - because parse_bin() expects a known sequence which isn't the =
case here.

Thanks,
Avri
