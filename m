Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA027472
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061292; cv=fail; b=Bs0NaIQ7m+tFS6dRVrcLKHXLa0tO+NiOjpeFIBcJ0443Nlsc5pkQVWzYr0cdwfMciUaXeBwJLR3pJL1EFIOZBpb1SkrbU/4+84c3Ytio7U2KRE65DNWQIvL3Oab349hOp/MYTUWQ2jwsSiGtY1EwUCK6utip8r58cjdqnloxgDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061292; c=relaxed/simple;
	bh=XAO9xYuTOX0jba4dkPHswuoT2V4iXx3zdSFtHvn85KY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=be54eIA67LVr+qzKD5eevLjsgse+hGk4LQoMGer7Ka3DbLU8A3U/TOENrd3Dud6ui6cudrp03VC6T03OUEVZYSYAfr6KhRfKO56fVC0URxr5upQ/fPxkT6Nw+l34d5fiXPFtTuFgcQh11nGEs0zMv/xJzjw/Dibi/ozxM2FhEvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=jwY9cH6e; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="jwY9cH6e"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764061292; x=1795597292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XAO9xYuTOX0jba4dkPHswuoT2V4iXx3zdSFtHvn85KY=;
  b=jwY9cH6eXXnjpDPlOU700mMOdGUz4epG85sN74S/lSIN1ihXF6zjKsYp
   l+WtrHvGs3dUh2gp1rNYnRpsQx7Yq7VdyAFmAv0iypMRpFQAwDeJ1e1LE
   qvx4Ixqt3rwBERuRmtbUBxQBR/CSpYl+zPG1S+gikYyBhkjKNuHDkiRlB
   fl6PJSwEEJEs6Qk68L8lK4QwdauXgodr68zHYzeGqsY3dhXTJdHX44GX4
   aurfUcXjvJjyHqJb/OCP8eBWt7dUdK+4LeHwveIISxrhYfIbiF1GXSUby
   MknOO0RD+XplWfiQugurqxH9qp8hyeiaMwpVgRL08MPUEno5b8JYIp+cu
   A==;
X-CSE-ConnectionGUID: Lmtp2Aa9T8OfSoxLIkhEkg==
X-CSE-MsgGUID: 1BecsOLqTSGegHCMLw2L+A==
Received: from mail-eastusazon11022131.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.131])
  by ob1.hc6817-7.iphmx.com with ESMTP; 25 Nov 2025 01:01:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZjnb0eikZhHtO1JdbpO1yGvdOFPmxfe/hK5JIwkNPTM0z0ZehqEwl8AEv3m9Yf7t0XBvjetPTMrpIJyo/Bfllp/6GFbMuzP+gaYHU/h+kLtsP5on5KWGX78LsPatDhvuNzOXeAbvO35Z5WDrCHZxFKPsFAE6DR4OrgTjZejYKF+KS5WlBbYnfMHEF8Fhsp/NllI7GquiOQclR/w+yda7NFChYereMBPf8thZDJnEoTFQDgfM6cNkxzKvt1oFzbeGumfBngK4vDy0u5ietYaFwcYC/pVh7Z6IM55SpuUWYHPk/+JwMQrIkP8DywMGCk1oahT/rT1Osvt1g8F2MlEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAO9xYuTOX0jba4dkPHswuoT2V4iXx3zdSFtHvn85KY=;
 b=Lah6HPYrgKrF2mt0BXyaR2fYocwvdFV8tCgrgvICqrdyY+jO6g2J4XleO+v5OCXfX2EjQ1Ikw0ekbT5Fl+n9D+u279q6U0k98neO1pPGXErFxteiU39UY6sBDeYAnBkjHPo268k4Sbt22MuwaPcV+FQapjH3SwlJgXHaJ6bgyzYz8T8FT7QRK45Q1Dcg1aawT4I+QOIwBG5paqUXazK1mJlxO82izCSYshMkCZiJR7FZTfSJnMLpfR3Zd5yCTfmtbI7d/KgGsKlf9LjXBpYG4Lkrb+xIn3j9frlIgM35b669SE90+xxyqZ7IkbrdKjWs1mEin4YfB8WGb+gQ584fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from LV8PR16MB6757.namprd16.prod.outlook.com (2603:10b6:408:259::17)
 by DS5PPFADBD11A36.namprd16.prod.outlook.com (2603:10b6:f:fc00::7df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 09:01:28 +0000
Received: from LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876]) by LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876%6]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 09:01:27 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Topic: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
Thread-Index: AQHcW35Y+KUsWivi60iGUFRu2uMWZbUCkRaAgABrt5CAAAZBAIAAFNiQ
Date: Tue, 25 Nov 2025 09:01:27 +0000
Message-ID:
 <LV8PR16MB6757EB0C84FA163C466426BCE5D1A@LV8PR16MB6757.namprd16.prod.outlook.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-3-avri.altman@sandisk.com>
 <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
 <DS1PR16MB6753C1E4EB804DA77041DAADE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
 <fecd4ac6-c872-4ab8-a7b7-c27505ed4639@rock-chips.com>
In-Reply-To: <fecd4ac6-c872-4ab8-a7b7-c27505ed4639@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR16MB6757:EE_|DS5PPFADBD11A36:EE_
x-ms-office365-filtering-correlation-id: a1fcb7fa-beb5-475d-52d3-08de2c0137ea
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGsrZTJPOEVpQjQrbDRKWEI4QktkU051Y2Vmd0FxRTBHS3AvOU8vUjNmOGJE?=
 =?utf-8?B?dmxNWkl1OUdOdlM5YWYzb21tYUpJMUorREZyOUZZVzczelNjOVhuZ2VmRXpS?=
 =?utf-8?B?c3V4M3hBWXJlS3E4dnBWdjFOQ1drZ01qc3N0UGNZQk1kVUtEZThyT2JZMmtk?=
 =?utf-8?B?R1ZVdzNPRjd3U1FxNjRLNTVUMkdNWHJIRTNxbG5XU3ltb3pvVEdkbkhTRmtp?=
 =?utf-8?B?eTc3ejB5VDdDS3RZcjVLT3VPcVpydnNLUnFmS3c0NlovVm1qRTFxNU5wREt5?=
 =?utf-8?B?OHZZSnNYM05tRm9mNDlvUEUzM3Y0MC92cnorcUprSzd0cy9WWW43cUd2U3NB?=
 =?utf-8?B?bWMyRk1kMTluUS84U01RSzVMWU9sVXJUcDZNRnRHY2M2TFpQaEhRN1VEL3Bj?=
 =?utf-8?B?WUhLQmc2T0MwbzhpRkUyZ0szODYyQnNvSmtZZThEL1B4K2JITlk4UXpxaDJO?=
 =?utf-8?B?bU1mNTJkNjRRa2VmdEZFV01yMmkvWENYRXZ3dXZFNGhWTlY2OUluWi92a1hi?=
 =?utf-8?B?c25xekpFL2daVmNVSlpaV2puS3ZQQUFYMjNBNGNHTTYzOU55UWNZRzVwcGoz?=
 =?utf-8?B?TWdBWFlCeHFwSmxOMHBkRnZpVkhmaWxTTWtxTnh5U1BWdlJid1NrNUdwZXZV?=
 =?utf-8?B?bC9SZys1V3Flc2dWZTNab0pmbFZSeGFFYWNtMVF4OFA2cWhIMDRTWkcxbUFY?=
 =?utf-8?B?Vm5KaWp0MHZtN25RNkNuT1lSZXFkdEN5enAwUGQxYU8vb21qY3hIekxGM2hI?=
 =?utf-8?B?Yk1jUDd4WkZZbUpCQ0N3ZlRWd2cwUW55RjBRSm9kcyt5bTY1dHpXVXRDOWlT?=
 =?utf-8?B?YVU4aEw0T1dYYkg5Z1JFY3o4MllMVis1bExIY2o0N2ZvdW5kMXQydS91TUN3?=
 =?utf-8?B?TURWVkpmVmh1dENLS05GRElTUkk4VHlXeDVidkU2TlBwL2ZIMUZReWRtMXN4?=
 =?utf-8?B?emszUTI2TEFYNFE0UFhGa282dnRMQ1h3aVYvTHdhZm0wckF0aGR6aEZtcVlX?=
 =?utf-8?B?c213ZzFzQmFlMFpQZVlvNk5VV1JiTFhVdHVRTGJJd25vN2hNZkd5c2M2RGVT?=
 =?utf-8?B?SEQrUEJ0aEpZRFNxb2JtcGJMZ3lQUlVCOVZsK1pMZXh5K3FpMDZlb0ZHanFI?=
 =?utf-8?B?d3kzRHVBYnBJdXFzN09pZXo3SzRBTjN1QmhUOHlVUmYyTDNLM2dRZzl6WGM5?=
 =?utf-8?B?QkFTTUZmaUpKT0hoTnZGdjc3czY1M2VhbVVRQnFpTmJFSWpEVmtTakoyUkc5?=
 =?utf-8?B?Z3dMRjluNkYzRlN1a2VBMFYrS1hGZXZCckVxYXViSkhEV0k4aHJRVzMxRlYz?=
 =?utf-8?B?bWE1UXY5Rk1mR0plTVhLNW9HUDhyd3JReVBubm9OZjVIeDIzVGtwdFFFY1BU?=
 =?utf-8?B?YU8rLzhEV3JuMWhrS0NmcG1VQno4aW8yUlAxdEQyZGM3MEhWOHA3ZCt4eVho?=
 =?utf-8?B?SWF2aTNTTEtmWUNJc1l3bnZDM05YSFhtbTM5UjNOaCtjcWRhc1NGYnlYTHpZ?=
 =?utf-8?B?TWRiLzZOSEFRbkljWU1uSUtkMkpiNnpyMUlkb25KUlAzTkhJNzVOY0lDeFVx?=
 =?utf-8?B?enNQVDFWUWdTMGJCOVNWTjAxcVBXeHU0eXd5UmpUMmNEenZqdlo3bys3Ty94?=
 =?utf-8?B?WlhIbStwYVpwUkJ2Q2lDclRHaWJmdzJBL2kyNnBZWDFhRm1wZ1d2Uml3ZVF0?=
 =?utf-8?B?T0lPYWlJRThsNGU2aEowV3h6RkdEVmxEMVdxRTF3ZS9XaFlJWUgyTWhUZzFN?=
 =?utf-8?B?cXlKdTdPOVdIdmljWkMvQmhtK1RyOUpwc2tNS2M4eFpPbVdkNkpUMzRxeHg0?=
 =?utf-8?B?bEJRYUZ3M3gvRkI0T2oyVTlHWFJTQTYweDE3RFhHbTNPK1dtSm9XVTlhamV1?=
 =?utf-8?B?K05DcWcwaytKd3BuWWhNb2dBTEQyRjZSM2dHQUJwQWx3dEx1SEZJV0Rzc2oz?=
 =?utf-8?B?OUZOMzM3R2tVQ3IxemVkeEh2dXd2aldjNHJyd0h1L2VHWUZaMzlobHFrRjVx?=
 =?utf-8?B?VGlKYkphVGxqQjBIRHJpNkVrZkF3a1JvRXNpR2podEhZRGU5NXQ1RXJRUEhN?=
 =?utf-8?Q?EJmQjN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR16MB6757.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3NqTEsrRkNTRWVzUGd1dllwWDhIZXJXSEJpQkd3RUhENnVYK09uQWdiWDFm?=
 =?utf-8?B?ajEwVmZ6MTVsU3FvRksvdlhzTnBqb3pUMGhIdE5nT21XNHZBZDZCa3EyRURm?=
 =?utf-8?B?d2Y2RjZUVGZxbEhCQU56eENxY0UrTEx5T0hRcUpxbjQyaWppbjFLekJjODg4?=
 =?utf-8?B?S1E1aHNiRld6Q0JCdDUvbHoya1pZU1NYaStFSnA4RVpQYmtjOVlPRmUzQVBh?=
 =?utf-8?B?MFZOZERoc1M2bVRHMTEyUm1WRmsxb1dMT2Y4OVdUM25VUjhLbEpUMklBNkFV?=
 =?utf-8?B?Q0lCSW0vWk44NkhQT2RUeEdURllST2UzcjJOc1U2RndMUlJ5ZEpRQWNDVVJB?=
 =?utf-8?B?V1VQSWNkYWs3aHNYa25PTHk4dTdUN1ZEb096YWMrUExRU1A3MDkzby81SnUv?=
 =?utf-8?B?ZmZ4bmlBRnY0R1oyR29QWUxncjR2SUNVOXk5SXpoVWtEdWlkbGN0M3lsL0ZV?=
 =?utf-8?B?NDBGTWt5SU8wZ1BIWk14UGQrc3Y2TW85MEJPdDFpOUZvUWFoYjF6K2JIcUt2?=
 =?utf-8?B?WnJlOVNJeGdCUkZ2cTBaeHh6cDMva3VDNWEvTjdZSmo5QVFDdVdtUXhxTTRU?=
 =?utf-8?B?Smh1S1VtUU9Bd0VneUQzU0ZSbC9UWGVINVBQc0hGYUtpbFNPaktBSnU5NXov?=
 =?utf-8?B?UVhYTHRFNXJxOStiUTYyYjVmYXZ3SkR0VElTdm1YWTlnN2dyeWhad0pDQWxZ?=
 =?utf-8?B?cGtZWHArRWhNN3pKNktWSFpDTmgzZ1JSV0RJbU4rRnRkdTU3b0tIYWQ5M1Nn?=
 =?utf-8?B?T1d1b3Q1dGFVWTBpVzFwQjB0WTRxdTUzUXRocGZ6OFBCRGNURjZjS2gvVEE3?=
 =?utf-8?B?RUIrRnNYYWdKMkdwZTB4NFdMM3orNTNLeXFXaENZNHZMMUtsbTRiQWppZW1l?=
 =?utf-8?B?bUd0ZUhudDNiZHViQUJUMGxUVHg4MEE4aCtPNVZhQnpPSGJ3RGd6TW1acUEw?=
 =?utf-8?B?TVhtRXIwQ3g0OUd0MGIzcFRyUzgzZTdJQTdwWmdnOFAvMGxsTVhtMml6Q1h2?=
 =?utf-8?B?SVArZnp0N0lYc056eG44MmEzcFMrd0VWUkQwTkwzSUFVV3hKSVB6R3lpVmJI?=
 =?utf-8?B?Yi9EaEx1MjZyU0JtdFpEYUJSSDVONUlLMmt4VDRJdmt0bFNkY0pjSXVNeWVW?=
 =?utf-8?B?V051UG5wNE9hd3VwYjc4R1N4ZGExSEVHSUh2YmFBSG9KelRRVHREakFTU000?=
 =?utf-8?B?dS9vcWFmZk1hUTRRclk3Q0puYVRML09PMzRacVI2QmxRK3ZHMExuV3BtSzRG?=
 =?utf-8?B?T3hBZkZnck9ZVEx1ZFdIUW9RK0d2eHlqNUFCQ2UrbXFrNkZrWGdmNHdya2ZY?=
 =?utf-8?B?MjN1c2dwM2FCaTA0dFh3bXArMEU4RUdLd2NuUzY0OXYxOTdiVVVUc1R4OVJa?=
 =?utf-8?B?K1lYM09kWXAzQklOcURuZEplWkNwUC9CUmNnelVyL2dMVjdXTVRZSHZtaWVw?=
 =?utf-8?B?R2J3TnQ4ZE5aeTlGME40YytjcjRIRGx1L0Y2d2tPWDkvUkM0VGVGdVY3bTF0?=
 =?utf-8?B?cnFGakZEMFk3Ry9ZY0Jxd1RLK2FJWlpjbkNOWVpPL0IvWHQ5blA3TncyZGtn?=
 =?utf-8?B?TUgrMmZXZk9ZNUtHZUdkNGZXTUFmWDkycXlPNExjSFZvYjU0OExzekhjRDhh?=
 =?utf-8?B?cUM1OW9DQVRGR0kxQTdSTU1Rd3V4bzdMVVI5TU90YmRHbGREbXhYRW1lQ0VH?=
 =?utf-8?B?T013QndrSjhwQW1ybjkzakw2ZmZmZ0ljUnppdHZGYkxyY2JrWTFjNG9BVUJY?=
 =?utf-8?B?K0hlSW1qczhOTXFiOVVyZ0VZaUtvM1dqbDJwT0laRjZOVzNiQWZFN3ZaRU9j?=
 =?utf-8?B?Yy9IcE1MdDNQb1JFWWYvbXFvV2lCSGl0UjdveVlYNmpnV01XQS9IY2I0N3Fz?=
 =?utf-8?B?WVF2Yko3MTV4VklMbnNTb2xXVkhJVTR6OWw4UEExalQ4bk5NVE9uZGNMUmpy?=
 =?utf-8?B?ZnpHdm5XcGM0WllERngza2FpZkxPSWdEQlNTYitlVDQ3Wi9DWVVLb0FyTDZG?=
 =?utf-8?B?cmoweHZqR1FOZlBqWVFhQkdiNkZXRWMzcEo1RWFPR0d3V0VORGNTRlU1bnZ2?=
 =?utf-8?B?bzRjZ3JhRkw0R3l0U0tEZkhPbUErMkwvbXpzdUMvMnVqWDRhL3Yza2E0SGRu?=
 =?utf-8?Q?N0TvQQVDRG4ZBHpKR539umBJo?=
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
	OASE8+u91dRNK0GQMT2YIH0IMPxRQyNi5TdG6MroKPL2ogNBTyOAuzrUHRz8ZdmFAfWf/5br/K8kdw0+CwRvgHUDzX1v2f1hYvRWR6y6H75x0h42xoQNQjZeOr6C7UiK+BbOSguA7A5t87JB0VZcrih9s/8dWRqzDEIFcDUK9B+S+Z8rzcRcd7lCUU08omijz4LisCKRi7sQB/2H95+t5qyTzSSrSiJCDD5fFeOCyePiRPDo+lVrT6EatChSurfLRnEmxM0dyqimIXPdb5nCZbVgEvhfHRovdSeAUlJsVNcRpyauA9efDg5pMBk3z+ZySVA3n9EME/qYjwEnvQx9/iQmYTxLq/48U0alFZ9lus5EipBqXX7z0jlZefk1L12u3S7kQNIf+pe61v55QoUIehTJheMD7paKOnpPbYzuQJRsYq7Kk/NyiHy5jg6W630eMAEsL+Mue/3Y1029zc+bDTgE6jPlDmrb5cThZhdnAfXXgEdEWY3BCigz3NR+Dr96mnh4klJ9xkpB+WNvfRs6TSiptUFX8323Abqvkp5oBsnxEshJBrU0yMpjJ4fk4qa2PafKnsPPl7kkrBMXjprMef3Qco4PjUa7c3maM+7zZ5B0cmCy7Mkpy/DPyQVMNR8G0Apdx4AWRU9UIMRl+I5w9w==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR16MB6757.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fcb7fa-beb5-475d-52d3-08de2c0137ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 09:01:27.7811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuzQ5MsgkID/sdXXcNu6v4EqgXK6asWEaraCyF292xJbsZWa7IbXuvZyRZ4QGX4GdIfTi7+dv+PiN82kUU08Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFADBD11A36

PiA+PiBXb3VsZCBvdGhlciB2ZW5kb3JzIG5lZWQgdGhpcyBxdWlyayBidXQgd2l0aCBkaWZmZXJl
bnQgcG9saWN5LyBhZGp1c3RtZW50Pw0KPiA+IFdoYXQgZG8gaGF2ZSBpbiBtaW5kPw0KPiANCj4g
SXMgaXQgcG9zc2libGUgdG8gYWRkIHNvbWV0aGluZyBsaWtlIGJlbG93Pw0KPiANCj4gTU1DX0ZJ
WFVQKENJRF9OQU1FX0FOWSwgQ0lEX01BTkZJRF9TQU5ESVNLLCBDSURfT0VNSURfQU5ZLA0KPiBt
ZHRfcXVpcmtfc2FuZGlzaywgMCksDQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgX19tYXliZV91
bnVzZWQgbWR0X3F1aXJrX3NhbmRpc2soc3RydWN0IG1tY19jYXJkICpjYXJkKSB7IGlmDQo+IChj
YXJkLT5jaWQueWVhciA+PSAyMDEwICYmIGNhcmQtPmNpZC55ZWFyIDw9IDIwMTIpDQo+ICAgICAg
ICAgY2FyZC0+Y2lkLnllYXIgKz0gMTY7DQo+IH0NCkkgc2VlIHlvdXIgcG9pbnQuDQpCdXQgaXQg
d2lsbCByZXF1aXJlIHNvbWUgZnVydGhlciBjb21wbGljYXRpb246IHRoZSBxdWlya3MgYXJlIGFw
cGxpZWQgZWFybGllciBpbiBtbWNfYWRkX2NhcmQoKSwNCkJ1dCB0aGUgeWVhciBkZXBlbmRzIG9u
IGNhcmQtPmV4dF9jc2QucmV2IHdoaWNoIGlzIGF2YWlsYWJsZSBvbmx5IGxhdGVyIGluIG1tY19k
ZWNvZGVfZXh0X2NzZCgpLg0KU3BlY2lmaWNhbGx5LCBJIHRoaW5rIHdlIHdpbGwgbmVlZCB0byBh
ZGQgYSBmaWVsZCB0byBtbWNfY2FyZCB0byBjYXNoIHRoZSBtZHQgZmxhdm91ciwgZS5nLiBzb21l
dGhpbmcgbGlrZToNCg0Kc3RhdGljIGlubGluZSB2b2lkIGFkZF9xdWlya19tbWNfbWR0KHN0cnVj
dCBtbWNfY2FyZCAqY2FyZCwgaW50IGRhdGEpDQogICAgew0KICAgIAljYXJkLT5xdWlya3MgfD0g
TU1DX1FVSVJLX0JST0tFTl9NRFQ7DQogICAgCWNhcmQtPm1kdF9xdWlya190eXBlID0gKGVudW0g
bW1jX21kdF9xdWlya190eXBlKWRhdGE7DQogICAgfQ0KDQpJIHdpbGwgY2FsbCBpdCBmb3IgU2Fu
ZGlzayB3aXRoOg0KTU1DX0ZJWFVQKENJRF9OQU1FX0FOWSwgQ0lEX01BTkZJRF9TQU5ESVNLLCBD
SURfT0VNSURfQU5ZLCBhZGRfcXVpcmtfbW1jX21kdCwNCiAgICAgICAgICAgICAgICAgICAgICBN
TUNfTURUX1FVSVJLX1NBTkRJU0tfT0ZGU0VUXzE2KSwNCmFuZCBvdGhlciB2ZW5kb3JzIHdvdWxk
Og0KTU1DX0ZJWFVQKDwuLi4uPiwgYWRkX3F1aXJrX21tY19tZHQsDQogICAgICAgICAgICAgICAg
ICAgICAgTU1DX01EVF9RVUlSS19UQkRfT1RIRVJfVkVORE9SKSwNCg0KQW5kIHRoZW4sIHVzZSBp
dCBpbiBtbWNfZGVjb2RlX2V4dF9jc2QoKSB0byBhcHBseSB3aGF0ZXZlciBsb2dpYy4NCg0KSXMg
dGhhdCB3aGF0IHlvdSBtZWFudD8NCkkgY2FuIHRyeSBpdCBpZiB5b3UgdGhpbmsgaXQgd29ydGgg
dGhlIGNvbXBsaWNhdGlvbi4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gDQo+IA0KPiA+DQo+ID4g
VGhhbmtzLA0KPiA+IEF2cmkNCg0K
