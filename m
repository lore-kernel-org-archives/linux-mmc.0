Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967A6F076;
	Tue, 11 Jun 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121767; cv=fail; b=km1f5oWY4S9itMZYznfJlVCAv3my0D5cgr4gZ0yKqVmV7VRuntwrf61vxMhhorXzU0BxaWx2zUEyy/V8s1ddbUNj8cOynqtX4XxZxRCdAOn7DZRBI19KzaZeKVrHrXx1D9Z4XAT6i7r0YpyvKT3IStjfS+Otgvp6FhQ0GfVSC/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121767; c=relaxed/simple;
	bh=dun2vYwsmgZEslV2ZLPh4SaAxaY3wWFUZJDyN2ZJAeI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CmM11KyMemKpH/quG91xZdqdPKIb0Bwrc5GxiAzgJyHr6zSYUzaYYgHz80nql9yXrupo1sx+u8mlBnL+67wlQ+WQ3V2SViU0zM0NihLIezUiEs3g3Nz0XonjSjQ2CDUD955bJrPforkdL+sj4NVbF3escB+xuZJUXxhWHZeo1Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HOR7tnbm; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOR7tnbm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3wCbroIuDl5ewSImIgadRXzX1XKFchlY34LvVaYoS+KmWwmW6moeWvnekZC/RPzyn+U6rJfKLBFuPvVUcKxG/PoIbxobHPKlYvbFLjtYHeXx1xUEW30+0vCjV49DqKOUNRaBm/lvps0N540l7OkRYxUCks4O5ntJ+VX5zXA8RnNv1fxJMbBhbH21DtlxUIanqwCv+aiZl02kodpNHqGaXZBRTzV2eO3KfUiHGry57owh3LKF8qXzj4wiZocbOzG5fo51ekTa7T9XUIBcesDepPBljCqGFd3XDOKMkwdPeUJtFgvBJjlIeP7xgKdQoKTgTHupHoOE853IgnafQWIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY9VlYhGKTcII66ujtd1ACAj1CWHPXZlW+rEogHApm0=;
 b=ab+rR/dxbqMxBiVUiajF2pXn7Eg7qWG6RPzdTuJYVxYwpN1jKGtTNq9tKx4qmwhOG2bDKqVW7LvAN5MPdZVXyGb37+Vju8JyokQFhOk/TM9sFfCPtESZUaa0JzeRTF6P64a4aFQLplv/svQQUaD82Q1wTtPm+Bzbb9NMhfSpCf3CtvW48z654QMfKwVMatsUoPwx+rdc0wi6v12iKnMkYHc1DlR4Czh6wgTMJku5oOO2tdTJvuiv1GCDa6Arvez6Td0Qvpf1qoVC5WsV5pgIisRcR4j4FWf+3Dk28jic0vV9ioEyy6xKmg+e9+azRaAbTDXdtFA/X6AMVevN2JYVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY9VlYhGKTcII66ujtd1ACAj1CWHPXZlW+rEogHApm0=;
 b=HOR7tnbmJGDq4TmZAVQWUJ3v1zSAx6dkmAAlcDkmmCjC1jPMOaOtQP2N15ahzecB5I6AFImU5LghtIRxVTJZVhN9iivh6+CLIO5ghiURpY52Q7AXrea0WggTcExYE9Y/UjFMLRtjOR/GzSACzraEzY1gmRgKWlgH+m6w2P71bVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:52 -0400
Subject: [PATCH v4 7/8] arm64: dts: ls208ax: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-7-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121739; l=867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dun2vYwsmgZEslV2ZLPh4SaAxaY3wWFUZJDyN2ZJAeI=;
 b=ltvzfnWA2cHWuowqx0jCC5yuMRsjGCk11Zx9OZ6wzSxFwo9yxIyiM4+Nh5OWyeLaOJI4rm5sl
 wDxK20O5fJKBF49VxTCfaipDxJTWQ/8tcfr9VcS267YrQPE2a3ZqfNa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aee086-5388-4fe0-cdfa-08dc8a2fed68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REt2K05FTjB1TjlTSUV6VnlTOWRWcFVJZkhyU3RjaVIyUkJFMklhTW5IcS9R?=
 =?utf-8?B?N043QTVwbi9CSlNmUnhCS2VTVXBra3RWZ3dqd1NkandhY1lSdXA3T1AxRVdY?=
 =?utf-8?B?WXl0S3FWNzh3NGw3WE4wS216NVJXdFJ0K2VwUzhVZkFDVURCUDJFMlZ3bGJ3?=
 =?utf-8?B?MWh4c3lwaWpkc0MyZGFOUm53OXZaRElYdmZBZEFBL3NHbXBpRUQxSWdxUVQ1?=
 =?utf-8?B?V3pjelNhYjZFQW5NeTNQZXNKWU5vamJGNzhaNVdFSThRQlVyazlyeFZUUUg4?=
 =?utf-8?B?WGhiUUV2dGlMT3Y0TnlkUVVvV0FMQ2hhMDdKMXRyUFRpNjAwMXFYTEYzaEZl?=
 =?utf-8?B?VHhQVENGaG9lQUgxbkdldVFqOWpWM3B3VXhjbnV6dmV6SUZoRU5qN0ZJSHpi?=
 =?utf-8?B?ZHBxSlE1aXRFTG85QzJEMmtMaUNjUDJGZnBPT2J3a0JMNXNkdld6OXhpaVhZ?=
 =?utf-8?B?OVhDVmNwQXoxeXIzVE9HVlo1ZHdUVWp1TU5HZmYyU1crQWNlVWxGa1gzbmo0?=
 =?utf-8?B?RVNGNzQxc0tIdEZLLzV5UmpZRTBERXhzTmRLa3dzejBIOUpTZFZmdEdSR0N0?=
 =?utf-8?B?aERvUURzandYNE9GbUQxbGIrTTZ2dnFabWM4dE4wZzNwWWFSdmRtbTBLV1oz?=
 =?utf-8?B?UHU4cWZKYTNMd1hPcHp3ZW1kNWRxRFRVVTd4N2tqWkdmZGRUUnlFNFdOSFZS?=
 =?utf-8?B?RzRSbmtXOVl0bHlVc2tCY0tkL2hlSVFNanRxQ2M0VVVtMUpPSThzMEhwZHRy?=
 =?utf-8?B?TVlPS0xISTEzbjROV3VNRWJZNnkxa3g0RWhCMms4ZkF4VWExeURkNG9ZL2l3?=
 =?utf-8?B?VTJ0WFhVZXFTdUtjay9ZVUwyRzA0Z01VakU2VmJWUUl6QWU4aU93WWJobkgz?=
 =?utf-8?B?aTk5RitEQmlHUiszN0NFSGVZUS8yWi9EWS9ZSm55bHBYNUZxMnlnNC80WlRU?=
 =?utf-8?B?VzRTd3JERlE2TGxkdXJCWkpweDhvS05WeUZrcDU0cXl1di9qdm5MTlJsQktT?=
 =?utf-8?B?d0ZJNm0xaUtzN29FRFoxNXBQZmJnSjJkcC83ekRiU1VBUDlDT0Y4U3M4RWt3?=
 =?utf-8?B?Sys1N2RFNG5nbXE5Sm9YbStSbGc3VzJmR1ZneWRJdVJMNERseEdPSjRPbTJR?=
 =?utf-8?B?SmxoWlUxTGZsb21IaGM4aHRkckl4NTZaUVcvalRqUWRIanltU3lJK2EvMlRX?=
 =?utf-8?B?U3JrNXZ2WU50MTlXejFTT0c2VkdBdDJEbjIrcHlqQnFWQjNPaDMxVGx3bUxq?=
 =?utf-8?B?dXNGOWxZWUo3MXF2dUQxRU5qM1lvNWFvYllydHBaYm9xVFJWNGQ5ekhIdnRh?=
 =?utf-8?B?MkdHbTFCRVdDelJ5dmFPUW0wZ3JuOEZib3Z1YjRoM1FGeitVcHNBeGJLeWxw?=
 =?utf-8?B?aENjUms3SU4vNWc5bTZXcXlndDhZa0V4Sk9QbjQ2S2IxV3pQOW1xOTdxSWYz?=
 =?utf-8?B?REtBMDFiVzFnVGxpZzJZKytuUFczRU9nUVBoeEZFUzE0M1cwWGhVMm9mdGdN?=
 =?utf-8?B?MUlxbTliakN3V2c5YmdjeGh6Z3ZRdFpvdHdnNTZFL1MyRklHdHlEQkgyQ1BL?=
 =?utf-8?B?N0J1cDVPRldEWjhrODNjOG5haXI5RWgwa0I2VGxpLzYzYkFsUzNNT3FOcGRn?=
 =?utf-8?B?SmxrRDhDeWhZZkVwelZIOHNVVXZGN2NlR29oQVN1cDZFbmF5OXFhWGpqaGhD?=
 =?utf-8?B?ZnFxa1RSMFhIWm9RTWJtTW8vaWNsUm5aTmlDd3ZQK3VsZnFtRkFVYWFveDZG?=
 =?utf-8?B?ZDRsTFNRWGJ4a0haWFFpVjhLNVdtRkRvSkc0VWZMWGxxN3ZFSTIzL29xdGc5?=
 =?utf-8?Q?aAWu7X8GTHLFaa5r1zeD3TIy6eZaXa1n7gwZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmwrdGRzTGdzMmdXRkRyUUV6WXpJaWxxcmpZejhCM0xFcGI3bVp0dG9GRC9y?=
 =?utf-8?B?dGVFQWFNazhPR0kySWMzck5EYjVYNDM5clNmS2VDZFNCeXpudEJNNFhpWExt?=
 =?utf-8?B?N2ZHTzJMU1NiRkJGY2tKcDZwN1dMUFp3Nkc5dEJ6c1JQUXZuQVBBU3dNU2Y0?=
 =?utf-8?B?TmpzMHk4S29JZTFNQ3AzZmlSWEM5L0g2YnhocGZ3QnEyTHlSWjJZT0R0bkNW?=
 =?utf-8?B?RTdHUTd6Y2QwcC9qZi9rK2lFTjduN2tmbWM3MHZBKzRIYVBFVGQ4UXQ5VmQ4?=
 =?utf-8?B?UFhwMWpaSExxMzlaSElJYVl0NmZDNzhjaC90S2tmdU1ZU05VWGh3MWQydXlH?=
 =?utf-8?B?ZVMxZ3VUQTdXM2FwT1d0TFVSNWVMdE5DQmsvU1FpaHZnTy9sQUNIRlRCeE8z?=
 =?utf-8?B?cGFMTzNvT2dibG1STm1aMldPNDRiTE9CbXRjWEV1REYyazlTdGhRQXNwbksw?=
 =?utf-8?B?M3REbG1Bd1M1ZmdEa3FIVmIzcWJSQWJ6OWdyUDZnaVliaXllVW9acC9MVWky?=
 =?utf-8?B?blJmVHZZanFodGRTbFZvMUhwVlJaS3JOK3dYRDNPMkhHcWxpaklSQTJDTjhH?=
 =?utf-8?B?ZE5nZnUxWTI4dE5TdUM1YnVIZTVlZDYxUWdQVGozQ0JUVmlGY2JpYnZqZXl3?=
 =?utf-8?B?Uk92akdYZXBsTnRGSXJucDlveE1BdXZDcjQvSFBVUHVTVVA0RDlYcWVmUith?=
 =?utf-8?B?NXk5ak1ISnZkdCtEZDRoelowYmZoc29JaVNjMXh6UVRjSXlXbFFiZGV3Slp2?=
 =?utf-8?B?V0xqUHdWZUF5elpvSlg4cGdHWlg5M2dRaGVmZ1NhVDJ1QnFOam91blR4bVlF?=
 =?utf-8?B?bC9taHNSWFFRd0ZpS0RHWTBjd0c4VU9kTFp5TS9qTFYzbnVSVWV6Q1BJY0c4?=
 =?utf-8?B?akNjQnNtNTdLTmo1QkdhZHMzeWlvdUhQbC9IK1hjWnk5RlZrUlAzZ0Jrc3h1?=
 =?utf-8?B?QVJTMEFydzhKNWdWWTBlZXZac0FmdGtTR2lIbmgvb0RKWGFGZjd6Nm1NN3JR?=
 =?utf-8?B?U0ZlWVFDVml0V1NYNCtlYnVoVlFXNW51d3NJeUJQbVF5Q2k1TnF1UzF6UGM4?=
 =?utf-8?B?M3hvVXExaFdaZThwM3hNWm85NEFqYVZOSG9mQ21NV2NKUnpOc0l0MUxZMTRC?=
 =?utf-8?B?Ti9hWnl3TSswSUFkTEVJS0NHUHpoQ2N1bGQ2SmUxN05hV0JHYWlFV3Q1TUh2?=
 =?utf-8?B?K1lMaU9Td0VhaWZjTVp1UVM1c1BKTW9rTEZiMkpIb2pOcXpUT2lheExOdTQ4?=
 =?utf-8?B?WXczNFA3WmNpa3VJUHBFdnBLQXZpUEsxUEN6Q0lGSGVUU2w1Skk4VkMrK0RT?=
 =?utf-8?B?NVdMdXU5NjhmcWd0YjIrYWtvL24vaTNHSno5V1Y5WmJnSFd2cG1td01NOTBq?=
 =?utf-8?B?RW54bkJ2UDlkSVlOUXJ4NGltczUvTEpqL3doZDNGUFNjVjhwTTFteHlVVVlL?=
 =?utf-8?B?eWQrMElqTVR3bVprQkNZVFZHUklXL0EzR2hjbDVtZUlUaUh6dllSdXVhNWo1?=
 =?utf-8?B?WXBoM1Zrcm5MZktwZkdnTkg5Um5Va080Q0FnMlJoTjAraFU3KzZ3UVg4NGx4?=
 =?utf-8?B?UDVERWthTU0rTVhwY2lZWElKQ2ZaU0wwcFRIVVpmY09VNUh3UDlhenFlcFFL?=
 =?utf-8?B?dVlFSWEvNlc2bC8rZVFKSmFrcmVFK0M5dTFuNkRTWEFGRS85SkphMEVEM0d2?=
 =?utf-8?B?NnhjdDluQ2pUZ25ualI4RWdUS05rVGtFU0lnL0hoUE9aQ1RuMGF4UXdCdUJZ?=
 =?utf-8?B?VEdJZ0MwUFl3aHhtS0xGVVJBOEZuanFhdjNFOEk1MC82N0RiRCtYY3dVK3Q5?=
 =?utf-8?B?Q1pUUTFveWdXR01RZzAyellpTHFUYUZ2eTQ4OW1NV2h5Ly8zQUFMK2NBL3Fk?=
 =?utf-8?B?LzM0VlhVUWV4RDNQMCtWaDZvU1NiRDRZTS81WWM4K1VvOGlxdlZCb1NDVDFv?=
 =?utf-8?B?YTF6eHdOcjNSUGh5Lys0RXE1N1pYS09XNTdRTmowV1BlMGJLT2RMa25ua2h2?=
 =?utf-8?B?K1dWMllUbEc1Sm5oNkRNZlJkZFl1MUF6Wmc4SGtwVHpSUEpRaEZKWUprZ3VZ?=
 =?utf-8?B?bGRMa0ZPaUtZODgvTGNWUEVFT1g5UWlPaEUxMW1YcXBDZ0syQ1k1NDIyVXBu?=
 =?utf-8?Q?fbojkh+PkAs0So1KXZ7s2f+Ff?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aee086-5388-4fe0-cdfa-08dc8a2fed68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:43.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D87p5nE5uj21Z1YJJnCKLkMHWlMk3NMWe2gBN3kxNIprgOuhuxZAckKvJttHi+JMigeUDuevETQCVvbTfHjjgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' to fix DTB_CHECK warning.

arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index ccba0a135b247..80fd1420d2299 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -940,7 +940,7 @@ dspi: spi@2100000 {
 			spi-num-chipselects = <5>;
 		};
 
-		esdhc: esdhc@2140000 {
+		esdhc: mmc@2140000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;

-- 
2.34.1

