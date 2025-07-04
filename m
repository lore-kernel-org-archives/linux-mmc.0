Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB51327A3C
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616078; cv=fail; b=JBkmf0sYifxpF0V+BlwFlRntyPmwcMpq++EAlbHxrt8ZDtwBFU7AaRg0izxd+nttkqSt1Q+JspUL9aVdMivISd6kOo0iiGQUY6iVUo0TsXwXmEHVA41dfPHqHAXD4zOwACLGoPbbYk6aUPPawIz8F1mQzgMRDGZe8NmnHDXhUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616078; c=relaxed/simple;
	bh=ytlO2tJkA4fml6gOAF1dcWy/1Yc/UWCq3Lu9S0WSxyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIx2X0ThXnaPT9c8TJ63RVYF/tE7mymgC2/mw7HVCnqAN8vBxagdSLZuS0SttMJaqijifmhXtRbFA6QvYxktbDYL2MTU903L9s9Z+F35uNgyAmNlTdFkeLFP/niQg++kR7gARMzLUY5H7Fd1qEmGYPT1DcNlcSW3ExBRkIuvKbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=BmrxuSGC; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="BmrxuSGC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1751616076; x=1783152076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytlO2tJkA4fml6gOAF1dcWy/1Yc/UWCq3Lu9S0WSxyE=;
  b=BmrxuSGCqwludXMCuCCewmJKTlGUW7UHibE5zdkatekaE9TVp1rOCb8g
   jYFThwxCPeg6Q+rgHx3HwYDNtlCOt+4M4VAbapWoDeppJF/DuRT1LPppB
   mmZ5zp6YzDUoanajh6tG80KyGJUjL+fKZYW7RhchCQZcA88cfBSn5D3qJ
   b54vH67D+jYocEf5avAXrApzDKS56h2DBZkD2y8zWDbIiK4HduEsKeWlj
   xt4g9cgEN5B4qAy2VGBsorTln3EiM9wMVzd7IqBz5xaPfoNkghXdk29X9
   6RQflBvNPTtbCkfWtr4tAsRAitwMOpXsk3AUdAtjzF6tKbk3Esq5bOz8J
   Q==;
X-CSE-ConnectionGUID: 9GLk+R7VTDm8+5hsxGia0Q==
X-CSE-MsgGUID: siminP+MRxCrpqPA0wLZCw==
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.126])
  by ob1.hc6817-7.iphmx.com with ESMTP; 04 Jul 2025 01:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoXdu9IYwqbCq/Te1SvIaNXMsYrHqGqHv7MthFq1z35RCtW73se1ArkDvVyorDe6dvNxvS84xiQx65M/pC9zTHX/gVI4ZKy5TiGUrFvXHl7xU9mO3E0DsvHpY0NHyjdflP+NY5EnlXAuynUlt7Gyio/9U2Ldc7WURB/XOOsb4y33yQFGcNfL3lCFVQhIHRUr1koo+NwH+S8yo4eirkI17KIFgKiqt4WBKH6HK+uxQtWf54l+3vY9OPZdEBVg5NXqVKORf98zvbso+P6VDR/U/KbhR/2ahJ0yzUSAnCqIFs/PpKXLXAc7CWatxUijKmG0gnxfr1msTJGRjzn+iY5Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytlO2tJkA4fml6gOAF1dcWy/1Yc/UWCq3Lu9S0WSxyE=;
 b=immrvB1eHNZXYVXYhjQgm+yOADhdC+fld7ya8btx+Y8BfIAv9dXP7sqX7N6nte9tAMQ0o3aAd42Hy0EaBD3+jMhqjpZnE2q9VXQj3Q/K8z6kWLOqx/DM3b9Scdq2yZQ2RD5znLPeFe7JdXPDWfZUylDbenkKkzLB5tJsrP7YXaL6aLYd/0uE/DHWWqIonLqCLThGvQiT9dUllEM5CEEtdiyidEugHPd+A/18uL4Xq3LGfCe7nCYUCId+S5P/TF77sRWxhfKa8/dlOc07W5bzPnoLY3pxv3IPJTP6KTPrjVpQhJKH/7+abc9UDc5Ej90i/35GI8FiZynFNSq5InAV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by BLAPR16MB3762.namprd16.prod.outlook.com (2603:10b6:208:27b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 4 Jul
 2025 08:01:05 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231%7]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 08:01:05 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Avri Altman <Avri.Altman@sandisk.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Sarthak Garg <quic_sartgarg@quicinc.com>, Abraham Bachrach
	<abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu
	<bbasu@nvidia.com>, Sagiv Aharonoff <saharonoff@nvidia.com>
Subject: RE: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
Thread-Topic: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
Thread-Index: AQHb4PkOT2gvXeCCkU274biaQkvqTbQhsOwg
Date: Fri, 4 Jul 2025 08:01:05 +0000
Message-ID:
 <PH7PR16MB61960E4CD85BB8076FB1977DE542A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
In-Reply-To: <20250619085620.144181-1-avri.altman@sandisk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|BLAPR16MB3762:EE_
x-ms-office365-filtering-correlation-id: 7513d4d8-0ccf-4abc-82da-08ddbad0ed7f
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3duMHphbmp4aDZWUkJ0bGNHRmNBdnNGT3BvTStLM3hreEFSMiswdENNVXRu?=
 =?utf-8?B?OExoeWtZcStWVWVrWHJSU2pwYnFCK1pmRnEvVzlJTEFBRzRPMDQ0eDArQVFw?=
 =?utf-8?B?blM2REc4Z2tyS1JpQzgvWjZkc2RKNDlOSlpvT2xOQy94bEpKZHRhUHNVTkdE?=
 =?utf-8?B?U1ZFaG5xQkEwNmNPV1Rac3l3SmVmOUFTK0l3MUNPOU1TZng4WE1lZ2hLTzNX?=
 =?utf-8?B?L0RIdWg0a2RBVjk1ZG1naXkrRmdLUXFodEZ3NENRVkJOU09Pa0NhOGgrMHk1?=
 =?utf-8?B?YWtTQTlUQUozR3FJaE1OSDdDRlV5Y3pkYS9iZHNrQVRHMW43bnpkclpDOWRJ?=
 =?utf-8?B?QXd6ZFlENXoxMHhnZ1dUc0ZVRHE0MUVSM2YzcDQ2RUhLQURGeHJvV0dLOEMw?=
 =?utf-8?B?elJhOXgyQW5sOVVMZkg5NHFyVDYwOEFOcTdRK3NhUUY5ZmxDV3hlZnIyeW1p?=
 =?utf-8?B?NHkxRVAwbWlnKzJMa2s4MUp2MDR2N1AzQ1R2Z3R4M1h6Vm1XMlZSUVJ5aWU0?=
 =?utf-8?B?SnFzdXhWODlyQ3B0R2ptekkvYndOQXJCbFh5U0JTKzRPaC9UNGJPeHFlV1ZW?=
 =?utf-8?B?a0RWRmt3bTQ1bGRsRUEveHlrY3dNenpubUYzTFNXYWVSZzJIVUJreUN5ZUlw?=
 =?utf-8?B?OVFGbVpuZHBDc2puS3BrZGVsRGVlVVgzb2JmL0JUeGZsQ1Z6QUx5SjFWNkFZ?=
 =?utf-8?B?L2l5aHlrS2xmVkJxbE0xYWZ5Y0taanEzV3RiUE5OU1R5c3F1WVlSTDJqTFZP?=
 =?utf-8?B?STNWd0FaZ3hPVHIwNU9rY1NXSFdGcDBHVHd4WklmNTFTcnJRVGdSK1pSM050?=
 =?utf-8?B?UUxvd1BkZ1ZFa1l5K1FKRGNraU12VUNqZ3F5WVVZelZaT3VJZkpxRzd1QTZN?=
 =?utf-8?B?M3d6cGk0Y3JDL0thTHZ4RXNZclpkcW1XVG1WRjVvVHFLTnlvUG9YVFdZVnJN?=
 =?utf-8?B?aTgvSGVjelFyYW5IcWcwc2NPVzMydmhrZ3loSGZqKzNCOHYvb0FRKytCU3hy?=
 =?utf-8?B?QXg4ekg4bDNmVGp2K0NPUnkwN1JtejgxOGlFT2ZZQlpjS0I2THZpaVo1ODZM?=
 =?utf-8?B?emJha2JqREpJZ3ZaZnRmejFmYlRrdjQvaFV6cDR6TDJLaVMwRHQ5TmtYZVNh?=
 =?utf-8?B?Q1JKOG5kMFVrY1NXZ3p2dHA1VmpDbTFma3JNdTRVTzNRN3crQ01SSzFja3RH?=
 =?utf-8?B?Skwwa01INXh5TlYrbUZYWDI2NzQvUHgrWVQ5aVNTY1hUeFB4V1EwYUVRVlRk?=
 =?utf-8?B?SnZQekhvMGphM25Sek8xTEFndXlBQlZjZElvWGxJbDBuciszdm1BWjJ3U2tF?=
 =?utf-8?B?Qk85NlZCZ3dqM3Z0eEpQUHJlZHpIMHUrMURVYlFBWVlFa3BxVXY2RzlQK0pv?=
 =?utf-8?B?UytaRFZWd2FWVU5ZeDIvTGpmZXhZSzhXekJaZ1ZxZHlLcjNTOFEwbjN3NkFw?=
 =?utf-8?B?elBITTRyaUNXTlNYekw1QVdBR2NzR3VxSEIxYUxSSWExN1RFWG53YmlqL0RS?=
 =?utf-8?B?emhaS3hEK1dzWlpqRjRWUnM4QVhjYUdubjRoVWJ6bEFvRFpUellsMnVvYzEy?=
 =?utf-8?B?dlBTK3FDQnF4dlUrbGpLaUUrRUxwSStkSzF4M1htUEVWQ0RJZ1lseVkydWhp?=
 =?utf-8?B?KzRoS3Q1Skl1cEw5OVZOOGxpK0hJNmtPNmhhaWhjTTc5em1haS83QXpHTi9l?=
 =?utf-8?B?UTl2c1ZVNDh6UDlvRnpyYllRNFlPSThIalIrbXFkM0tLOWQyVllyRjN2OS91?=
 =?utf-8?B?dXh6VEZMTkpYNFZRVnRpd0VJdENNUFZydlJvS0Mxb3puN3BFeVg2TmVQSkRB?=
 =?utf-8?B?Y2Ewb1Q5dWkySldnVWVPaXE1VEkzckxUMTFxNEdZMjRGM3B1R2JNbE1DMk9T?=
 =?utf-8?B?d1drQVRwVjFHamZDTSsxaXNZTEdlOURZTTFZM0ZIODlBRm5oYm51NWlLT2ts?=
 =?utf-8?B?WDBFNm8ybFdHdUlYWk0vWlN5U0lGT0VSTzg2VTFDSDBmZldHMXorSHZ2WHJT?=
 =?utf-8?B?c1NWTTZUTW53PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q290NmY3S1ZSODU4MTZmWVVVOTMxbU1iR0R3ZHZoZEl5MTJIYUVGWWpCS1lJ?=
 =?utf-8?B?WmRUcHA2cDRXTFhiMDRIQ2xaL1p2VHZGaS9kWEllL0UxM1A5cVBic25KeWJp?=
 =?utf-8?B?andFaS8xZVVTbmo4QTZMSzRXUXgvOE53OG5Fa295VDdOZytKY24xNHdUcWNO?=
 =?utf-8?B?YXh5MUl0ZWROUDhmRG5NUnFpRUN1L2tBaFZPSUpuSGxWU2owUi9vUUllQ1Yr?=
 =?utf-8?B?a202dTBySTZtOTQvOTk0TmdpbDNCeGtadE4ydWlQYS9ZeTljQXZENVVTSDRw?=
 =?utf-8?B?REZMcG52STkzR3NOclI0eUZsNjlXNUVscEtGdVNoeE9sWjduRGgwSEd6c2dw?=
 =?utf-8?B?empBUm1UWnJyUzJPSTg5ZSszTzBTRWl4THhnL2hUTFZTdXJZdS9yd0RQMzFo?=
 =?utf-8?B?eEhpUnZYYzQrWkNhWWp1VGNZRWRVM25oWU5Hb3gwWklWVys2eThzbUtWKytQ?=
 =?utf-8?B?a2dpZjk4bEU0aXhoWmxiMzdXbkRaZEx0dGZ5TExGSGxQNko0NDBYaHFDaUFV?=
 =?utf-8?B?aGxhbDVibE9XcUI3dllrUUNmNWJCVXE3WFJUY2RabTZROVRodmxYWHpPbVVG?=
 =?utf-8?B?MmRuK09hdXhMUmhnRExRMjVIaXNwQSs0YTRNdUVvc2xrdVpVVGRBTU9BYWVN?=
 =?utf-8?B?ZUcxY1RvZnRFakNHZnovYjVHN2MyK0gxNWtRRk85Vi92S0hWekpCQm9GMUps?=
 =?utf-8?B?OUltbG85UFZKd1ZZSEF5aUtFQkJPNi9NR29MYld3YnBrSUxVbGVWYnpESEVl?=
 =?utf-8?B?YlRhUFdJUVZweWVTWTFEaE5Mc2ZGL2NUTWF0Z09lMUxRMTBWYmVKajlEZnRP?=
 =?utf-8?B?dDFnSndnZE1tbm9ueXRYQVE4Qi9RbTVWajJ5WFI2SEpoVi9kanlmVmlYK2pn?=
 =?utf-8?B?dmw3WndwV0JaZjZTZEtab1pNbExjYWxrcWMwY0ltNGtJdWp4UW94ZFowQWt0?=
 =?utf-8?B?TGVEVi9jdm9iMWttTUtRMVovYndZdkNCSHRmclZQOUNGZU5oNlNnYldKWG1J?=
 =?utf-8?B?UUtnWjlqNUlQaXZPa2tZOTNGMVdVaTBTOEIvQWJyVU9md0RWS3lvQmhkcGFG?=
 =?utf-8?B?RmQzN0R2Q2Z6d2h3MXUrbXl6S3BWRXRxQkwxOU12S011L2NOYUUydmthb3Q5?=
 =?utf-8?B?dVNlem9BcnlWa0FnWGpQL00wV3dQY0dLT1VhNmNqQnJKUldkTjFJbi9EdTVo?=
 =?utf-8?B?VE8yZmRob3JrZ3dXcjJudUp2Y0w4aGx2ZE9rbEZJMytkdThtNHl1MmZidW9K?=
 =?utf-8?B?YzNRVlY1QUpYWFkzZVJrSmxuVjlrQ3dYTXN2MEVBeExna05HNk04ZHdYZlhG?=
 =?utf-8?B?dk9CZHpLV3loZFN0bnNXWGtIaHRnVHpxRmQ3SjVCTGtnVGF5dEpKRUdzZm5I?=
 =?utf-8?B?bUtxMW0wazhIUHc1UDV3TmYwUTM2aXVpVVdkclRTMERPUlVOTXF3dmNNem5Y?=
 =?utf-8?B?YXBwTnVLMHNweEVRVWFOV1MzSjMybG9kL0xlM2hkWE9qcHBraXBLblBTcFQv?=
 =?utf-8?B?c1lEUUxtMll5QXNhbVR0aytsZGpIWGpjYklUU1JLOXRjcnRIa2ZqOTJTUHVz?=
 =?utf-8?B?Zk9ab05kZVVpUXlvaWdmb2tnQVdCZ21WUktIRVY4ZUUyQi9CbjRydVJad3d2?=
 =?utf-8?B?djJNR0xVS1MzSGMzSmdPcEpBTUYwZUV1NFh3TkxMOGQyMjhGVVlOSm51ejd5?=
 =?utf-8?B?TGtPVmlTZzJYcHNxVzVvNGd0ckNRTm1YKzAzMzBmdDlnc2g5V1FoYWtMTUdI?=
 =?utf-8?B?VkxENy9IMkNrK2pReHQveXhidjBmSHd1eUs0b29tcng4R081RUxBM3phTEN3?=
 =?utf-8?B?cDJ4S2ZLbmJnanlnRlE0d0gySkpyVC9sVkJteDdLR1pqR0Q4dDRpZFdDbFFU?=
 =?utf-8?B?YmFyVW81SSthbjdGVlA4R29rL3Y2eDNCSmpqUDcvTW5LZ04rOFdWbVhjN2Yw?=
 =?utf-8?B?REt2VldQaEwvQnhabVFLWk1YdjJsR3U5MCtrVTFKcWxxTFJFSHBlSTVlcmVy?=
 =?utf-8?B?R2szQkhLUmZUL2J6ck16cFgwdUZJYktXMStXaUVSaHdDYXRWOHl5Q1BiZSsy?=
 =?utf-8?B?VnZoaHFCc2E0TVg3Wit2VUVGN2ExYzl0K1FpKzRRK2JPaEtJQnlhbW9yQUFm?=
 =?utf-8?Q?Os/54VEiq1JxnkZ883HpOP84/?=
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
	Xpgqe1BOilmSaloXcShBuUDYrctjOtE0xo7nFiRK7FppML1TVEdqzqjYq4DmT13H9lrDO/dg/ceZuguwQr9hXFccDtASsycq3zmEcP2IvcyvnXwOkt+YFAiboKprdS5/BcWmGnJO41n27S14f+JK12LXo6aDV8e4OlMFlJWrlGvXWIqfaLhFH1x6j3egfrCf65SPwE2YWZO/aetrMlmZX1bsgDM4JaKSb5spc9vBz/lsi0ViX7JwzM8iJcCKLrX+hA7Jw0M+X08p7JJMtwMms1MUyLDT3P3qzNWZ2IfxCFo+dNr4eVubfqGzQkGEqQAzeezwaxUKwFSq3lNkKQVxZoknSfFvPm1ppDEO0pEUUeoL9bvgzmiyUxbEJASJAFsJ2DU3+lPez92j1uDwlAOeWqVGUsKyyLk7zm63N0Y/5l4D+w0XLgIkSENjwke0pGGvScMdL+R1jGLkwmxSvkYUtKX0PdCGrAYGY7mFRhBXCW03mbb8plw+wUD6Q+v7Gw3TMTogGL3osFhCXOIS5zDmzgPCcW/GmR/UBzVXTMjk7GedgHO3aFEcVcO4iUkZn1vPay+RdL8asmQ8W4cPdgQTI2xnxZ0qbfaklXR8LQF898shR2FmGpcOuCP9/lOidTl1/sszJr77rdCcVUHlt/Z/Yw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7513d4d8-0ccf-4abc-82da-08ddbad0ed7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 08:01:05.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXBq4GKjyKs+QjKDANykL8LISvhoIQgA+LxAGk9M3tyQmfAVU3NCjDkoPo+5vKSSdosmKdwEhOUq8nm7Hga6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3762

IA0KPiBUaGlzIHNlcmllcyBhZGRyZXNzZXMgYSBsb25nLXN0YW5kaW5nIGlzc3VlIGluIHRoZSBt
bWMgZHJpdmVyIHJlZ2FyZGluZw0KPiB0aGUgc2V0dGluZyBvZiB0aGUgbWF4aW11bSBjdXJyZW50
IGxpbWl0IGZvciBTRCBjYXJkcy4NCj4gDQo+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB3
aGljaCBkYXRlcyBiYWNrIG5lYXJseSBhIGRlY2FkZSwNCj4gbWlzdW5kZXJzdG9vZCB0aGUgaW50
ZW50aW9uIG9mIHRoZSBTRCBzcGVjaWZpY2F0aW9uLiBUbyBiZSBmYWlyLCB0aGUNCj4gcmVsZXZh
bnQgc2VjdGlvbiBvZiB0aGUgc3BlYyBpcyBub3RvcmlvdXNseSBjb25mdXNpbmcgYW5kIGRpZmZp
Y3VsdCB0bw0KPiBpbnRlcnByZXQuIEFzIGEgcmVzdWx0LCB0aGUgb2xkIGNvZGUgYWxtb3N0IGFs
d2F5cyBsaW1pdGVkIGNhcmRzIHRvIHRoZQ0KPiBkZWZhdWx0IGxvdyBwb3dlciBzZXR0aW5nIG9m
IDAuNzJXLCByZWdhcmRsZXNzIG9mIHRoZSBjYXJk4oCZcyBhY3R1YWwNCj4gY2FwYWJpbGl0aWVz
Lg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSwgd2Ugd2lsbCBub3cgY29ycmVjdGx5IHNldCB0aGUg
bWF4aW11bSBjdXJyZW50IGxpbWl0LA0KPiBhbGxvd2luZyBTRCBjYXJkcyB0byByZWNlaXZlIGVu
b3VnaCBwb3dlciB0byBvcGVyYXRlIGF0IHRoZWlyIHRydWUNCj4gcG90ZW50aWFsIGFuZCB1bmxl
YXNoIHRoZWlyIG1heGltdW0gcGVyZm9ybWFuY2UuDQpBIGdlbnRsZSBwaW5nLg0KV291bGQgYmUg
aW50ZXJlc3RlZCB0byBnZXQgc29tZSBjb21tZW50cyBhbmQgdGVzdGluZy4NCkludGVybmFsbHks
IEkgc2F3IGEgKzY1JSBpbXByb3ZlbWVudCwgc2hvdWxkIHRoZSBwbGF0Zm9ybSBhbGxvdyBoaWdo
ZXIgcG93ZXIgdGhhbiB0aGUgMC43MncgZGVmYXVsdC4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0K
PiBBdnJpIEFsdG1hbiAoMik6DQo+ICAgbW1jOiBjb3JlIHNkOiBTaW1wbGlmeSBjdXJyZW50IGxp
bWl0IGxvZ2ljIGZvciAyMDBtQSBkZWZhdWx0DQo+ICAgbW1jOiBjb3JlOiBzZDogRml4IGFuZCBz
aW1wbGlmeSBTRCBjYXJkIGN1cnJlbnQgbGltaXQgaGFuZGxpbmcNCj4gDQo+ICBkcml2ZXJzL21t
Yy9jb3JlL3NkLmMgICAgfCA0MyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggfCAgNyAtLS0tLS0tDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4g
Mi4yNS4xDQoNCg==
