Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D951A9B58;
	Thu, 22 May 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938560; cv=fail; b=nIr264qAI8obDo3X6Xlm1fO3QIybnyrxfCqMAo/OE1mVmOj209L13e1oiDrbBdyHqynJsvIYMIMerZ39ysOhu6xmwI7T/qRBgTiAXf4A9Y3B9L/euV4spxCGWbrFAB0aeevWap0bHb+5Okl9DrmpGjCNSHOhPQd8tB3hUt7uK88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938560; c=relaxed/simple;
	bh=YBobysIGA8toUWpcJWgamt8hKKBMxGJ6A8wiSDDVrdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NF0UZ30c1WTs5UsxapcMbWbonL819rQioO0zoHdJppA2KZh+NufomawaqUWyILP0mVAXI7Gdq9fM5yfl7RqEI74ZbpLbyLa7B5qkxKAFmkwGkzM2i4Wp8jppjx8QCgHGGp1I3lWt64zrj4xLUF8c8k3eglsB/DLLYGGyMVa910w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ftvFjk41; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ftvFjk41"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y21tf+CjYcpAhu1NUN1ObAWJrrIlzU2hVg+gq7hde/zWMMGUxNJK2oheo07PyEt43yPLuxM254ceVVnSyBJqSzF4o7/hAsGLaxZVZA4qv0D8Zy7hIlW+1u2BGXV86E7eQr1pyB2r8zuhMoI1izP4JglDnMxhBFPEOo+RC2Qj+LXo9MJq5xlS3gPx2gPPRnX9ZNARvTX0LvgD9eG1K03OIsOiQdbx45zbz3ft0Gi/AaAE/2oJOvnWSDfxVtPtMKiMQvnYSdtUZ+VimMrMlpJgdj4Okn7cwm6eYCceoA6ZVj8BeGj9juuaMw05oWnXXsIualVr6qDZ0XpXFPucDTspNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCO4mXplfDTIqRW0HoDVkDnpRtsJx70tkyLbpSei2eo=;
 b=WXnebYpeTmeRSIkNd4UTRb37wF6nEX+ZmN3auKPK+V8u8Nt+gEK58OwOR4I8IDSqlcoTSXhsugujnEaxtMQ6izT9uMgUWCe05203zTlLHqVrFaKqsiZBOMh+ykeP89zzy8CXbtNGgoaaL0bj+87nxCag3IeSr3Odc69HlhSAnr3jon3qh/QW0g3r0lFIouzvTX/clK6SFmfsBfmBuAcibDIip83B+a86uUYPo3wnBx1N3oxn8KMH+AOPGWHdUwQsj0qGHuTu8EgEER/Q486rxtRC1FpjoJ0QwDPFxe1QB2AL0Q4jEBkmk8KOU+WIUd4XLwPmYE2a7R+LdckCJVKzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCO4mXplfDTIqRW0HoDVkDnpRtsJx70tkyLbpSei2eo=;
 b=ftvFjk41sSMV9sHI0yDRdDxjaC4q/uYo1BOXjvXvrcXhX4v8FN0a/EQicPTL8tn8Y8OFxaXSBiYCGv1PdtdlOwqtK4gUWVYUKzFnpTf5qdyFghvs28PCtJNqF4tFM3j9qhIYbxp257BjtGixd26wWKr/6dcWAURe87T7qP84jgr/K7TzrRf40P4ON/JTQYk7q/C8FJ4gg9Er8W9jlQUCOMBC+2rCECFGuu0J9dWBcBuSA1m0iX/N2m93yKj+8S1/12Jx4NMq8kn9nc06MeRmCxV5+xGdAxKnSTs1Xjw6rnLlqLD2RFCC5xRd2Cnla++FM10t++jms0sewyHXMFpQnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10273.eurprd04.prod.outlook.com (2603:10a6:150:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 18:29:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 18:29:12 +0000
Date: Thu, 22 May 2025 14:29:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
 suspend if function irq is wakeup source
Message-ID: <aC9s8DLW8NcvF4e3@lizhi-Precision-Tower-5810>
References: <20250521033134.112671-1-ziniu.wang_1@nxp.com>
 <aC33qfRFEvNbwSRn@lizhi-Precision-Tower-5810>
 <DU0PR04MB949685245DB01F28E15C24D29099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB949685245DB01F28E15C24D29099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7158b13d-57f0-4eb5-cb0d-08dd995e8cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDY3aWdvUUtvbThSQUFvdlhoQmpDclI3S3N2Z3h1SEpxbXgyQnZvTkVQZmU3?=
 =?utf-8?B?Z2JQbnA5aSszeXdKOU0yWFhnNFFrQVZNUlBaWXJwVkRpcklBZWhKaEV6Z0xv?=
 =?utf-8?B?elNZY1hEOHZpNk56bk82QXk5VURZQXRBVld2SzRMSS8zR2ZsRTVuZENZcHcv?=
 =?utf-8?B?NzNYdDB6MHF4cFFMWFdGOXQ5bkxjdjBvUlpybVFzcTd4Qm1wcWErek0zUmd3?=
 =?utf-8?B?ZFhadTJhY3BHUTFZTDMwSEpqc1JJRmRqSHpySktsWS9KUzBlcWlKL2VVbEJK?=
 =?utf-8?B?SW11R0ZXVldHRE10czlIRTRTRVZ5cVpJOVMyZktqeVJkMjBRWFZVOG51MWpa?=
 =?utf-8?B?T3IxOTNibWRGRHNWVVFSSkRGRTNkTGlIeXJ6b0lXYjA0blRVNWtCYXhFbDdt?=
 =?utf-8?B?T1Ivc1E5S2xNOE91RHVHeFFXcjJiMGhtams2Q2JjT0VsMFdubWs4NVIwZXpr?=
 =?utf-8?B?OENuL0ZTRkxsbzNMQ2t0U1k3cGc1bFFEZGYwMFhEOExHMitKaWVPZ0g4Mnhn?=
 =?utf-8?B?TFFpUlQyT1ZkSnZsVzI1b3J5OU9XckhsakVJNVUzRHBUcVRlbXlzT1N3RWFw?=
 =?utf-8?B?cjM0aG11cDZDOFZGN1NkZ1hFZ0ZTTFgzeDI4T3ljekU1cnlXaDkzdjNxdm9k?=
 =?utf-8?B?WWZyd281cXN4d2JlcjRrTUtFVVJlWXpWMnNpOW1KbVFmdWZBR2hQZXVpSHpG?=
 =?utf-8?B?TEl4cGxVQTcvcVRKT3QxZVNPVUJOY094MFI2elY2aUhnRVQ4cWp4em1xRVY5?=
 =?utf-8?B?ZXdxbWtBNmRjbHNFQXloUXFLVC9ZVHFJcldVY3JKUjhGdkVHS2Y4UklzVTJi?=
 =?utf-8?B?dGF3b1VQa2VxdVM0d2NPbUMzL1hjM1pQK1NUOFNROWRNdHpJenFRNDRoa0Qx?=
 =?utf-8?B?b2ZzMG1tdWJlQ2hOZXNoNE4yUjNzNEdVUWxpczBvQnFnNzdma2FqdW9BeTg2?=
 =?utf-8?B?YWNPdWd3VkRPb0FDeVV2b0VsNEdYN3o0bS9hTGNBVmZYdHN5TlNUNHoxcXpK?=
 =?utf-8?B?cEI3MFRwdWkya2MrcHl0bDFLUGZYWGw2TWlPRXdTbVA5OTNZdHNuZXl0Q3hD?=
 =?utf-8?B?bDU5dFo2SDlVcmpLMW5KV1VTdVEyVmNmZW55Um0rc09ydWZaWXNBbDVabDlt?=
 =?utf-8?B?R2hsczJzYUZlbnVpYmViNXhtR1U0RU1CM01MajkydU9Sam5MaWs0aENQTXR4?=
 =?utf-8?B?NXQxNzVLRDI4K0ljWDlndE1lRStuTWdydHhrVmUrU0FRYWgwZGNIc3JKelRs?=
 =?utf-8?B?MTBqK3NjZHhPemR5V0JUY3JEOGdESVRvSUJaMy9TYUIzbEpuQkRnUk5GRms2?=
 =?utf-8?B?Wkc1SkJXdnVVelZ3MWNzNEpwRWd1SDRwMVpybStFbnpkSzdSWDc2eXl1cEhz?=
 =?utf-8?B?MjNPbFlIcTUyVmM4ZHpDd1huSjhvdytzbFdVOTFiZkY3bkF4WWFOcXhpYWFT?=
 =?utf-8?B?VE9iamY4TGw3OVRiNHpzN0NoWWd6K0FydjBLajRaZ2V4dUZYRVBtbWlDZTJm?=
 =?utf-8?B?NWg0d0dvVEs0a05UVitSdjVaSGhka2d1UEJYSzVIZXZrNFplRWpwS0VQN20r?=
 =?utf-8?B?d01PNUUvMStHc0duT2xJTzE0YjJKeTVPRHhSeisxWnVsNll5NENSVW0zYUtK?=
 =?utf-8?B?NDhSWlNkKzYyVnVsMVYvQWppSnNsSVBBdWVIdE9Vc053MmtQdHRydG1pQmgz?=
 =?utf-8?B?Y1E3bGJWVURPZ3dyZ21xVlI4S3U2NllZbWZhdEJvdFdGNndwMEtaQTArUlh2?=
 =?utf-8?B?cmgxVHNKSXZlbDBtbGxlQnozV1JDbGNac3BSU1A3N3FKcnFRWGNzMFdFVWRC?=
 =?utf-8?B?Q05DRG5XVHh1NjNMLzFtakdJZXMrZm5xVWNlR0JTUXJva1RYN0Y1TXJKb3hN?=
 =?utf-8?B?UHo5bXBGUEU0cTRYcURuLzZuSDRDcWhMQUFhSUFYUzJDOThtTUpqajdldU8y?=
 =?utf-8?B?RjJmZWx0azRSV09SOFgwbld6VEkwOGJzZVk1bXVTRXIvclV0QXNTN00vNElY?=
 =?utf-8?B?NWFpTlNIaHlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm1GNU1MUGdGSU9qZzVqV3l0ZENFMlFuRnRZQVZNZDREL2JKeHNTaGY2YjNP?=
 =?utf-8?B?OWV6VkhCZmlKbGlGa0FMSW1abHo4L1d1MGRhdFdKWlE3QWVCekFQYlJmbFVZ?=
 =?utf-8?B?ZVo1RXFCTVpkcHBYSEUxaVFweUNDb043ZUlHY3RCajZoU0xWaG5RWEZMbW1K?=
 =?utf-8?B?QmxnWkVFWWxLVzNZMCtIVVZKNUhtTHVSQ3RKWlg0Q29vLzQxV2FRaWxIZkNz?=
 =?utf-8?B?TXd5TUdzSTlMNFB5Tzk1aTI1TmV1TTd5Q3d0OXhFOHNabUx0ZGpFM1oxaUNu?=
 =?utf-8?B?dDRGNEZXZnN3bWdjbnRkZ2xyVVlCVXZWSE4wTFNEQ00zNnFkVnVIL3FVTFRG?=
 =?utf-8?B?TGVmYmlicGNmNTJPb0pUWStEaVNqNHU3T0ZQUWViMjRTQTh4YUh2Vmx6QzlF?=
 =?utf-8?B?cTVHYzBOaDFseURIUFNPMHhYeFRLZi93a1crY0N5dHpkcnZoRzg2TWRYcU0x?=
 =?utf-8?B?N1B3NElvQkJxNlYydTluTEp0VFpObTB0eEdGMmlsVkwrNjB0a0NuYi9XbXpH?=
 =?utf-8?B?cmhCUzRZWnYxaWNER3l1N0ZBUGNacE1pSFZVSDEvT0h0UEhEOGhLcldJc2ZQ?=
 =?utf-8?B?bzdSaTJyWEpGNkYwWlY1UG5QbGxxd0ZuaFdWZ09lWkN6bTgyR1h4K21LWCsy?=
 =?utf-8?B?U29sOGk0M1QrbHZKQXVGRG4rMlVTQnI1ckh4dUhoVlc1TitUa0d6V1Jib21x?=
 =?utf-8?B?Mk1LcGlEY2tLWjF2MUVwaW16QXNiVGNSTnVBMi9HSjFJNXRWMWhsS2VBSzF4?=
 =?utf-8?B?N3EwaHZBSWkxMC92d3QxWndEUlEzZ2xWVGQ0NnI3UWEyTW9ySSsxZFhObEYx?=
 =?utf-8?B?R1VIdHdPWm5LelhkK3FxYS9UUHIxY1RYQVIxbDRteHYvemNZazN1S3NGRFhK?=
 =?utf-8?B?a1FIck5FTEpVcXNQUlJtdFBtN0NxRU53RTZsRVpodWhjaktpTTZ2VUF4OGx5?=
 =?utf-8?B?KytJSEhrcnNNYzNNWHh4QUZjYyszOXZSRmRDVXZKMHRXVEFmUHc2VDZYaXRh?=
 =?utf-8?B?a2VoQjB2SlNnb2JTRHVwOXl4S1BuM0xIaTI1STJ6dG9oWmFzT1l6Ym8yUmR1?=
 =?utf-8?B?a2ZwdkwybXo1MFFxckpweUJ2YTF6M0pxVlVyOVRRNjVQb3pjS0RKdXdzOWZz?=
 =?utf-8?B?Mi9UeE5KR1JPS0JTaXBzcGhOV2hJbGV4UUM0YXRDdmd6dWtLS3V5SCt3UVBK?=
 =?utf-8?B?MXBucHJLR3U1YkNReHk0VXFaVGNrc3N5dmw4NHdwS1Qza1RWM2pNVXBXM0Rn?=
 =?utf-8?B?S0lFeVErSWVUNnBWRWdFc2JsZG4vRi8vZ1puaVg5Q0MxM1NjSzRhTktYZHUy?=
 =?utf-8?B?ZXNCMnkwZXNDak1aN0E3ZGJJcmQ3cVdMc2d6K3Y3cjZhTjBVQktRVXVuZlVn?=
 =?utf-8?B?eCtWU3R2YzdIYk1DUHU5aysrY1VRK2tucmRJMTR5UFhPaUNwY0tHVlBrQkg1?=
 =?utf-8?B?YTZBME5QclVEVXF5V1VNdmRXR3YwZGY1YzFOZkdGR094ZmNodEZka2ZWU2ZZ?=
 =?utf-8?B?cWg2M1d4aVBocm9pNFQ2N1NqbFFiczNBODM2cFR2ek44QStaZGxLRDBrMEFy?=
 =?utf-8?B?aFhRYnNPOEEzWXgxSHllRUhzUmFhSFl5Rlo5YlFBbDB6c29pTlBHdnlVenBC?=
 =?utf-8?B?Tkp6amptRTAwTEVlRCtiQXNMZEZMMUdJcWdIZFhUMmJhd1NyMnR6ekdFVkl1?=
 =?utf-8?B?WVpUTXl6bjViMkIyRGlqZEZ4amtUVDl0K25JZ2dWeG9CUDdBM0RTaEtsVlht?=
 =?utf-8?B?cFViazJMYTJVWnM3ZUxXTGhhS01wRjFnNzViLzlqWkRtMFd1d1NnaHdXc0dB?=
 =?utf-8?B?NWJaVUNwT2U2bnVmRzZMSjFzdGRpUnRSK0dGYzNEd2hraEJpOUp6RDM0LytZ?=
 =?utf-8?B?SjJwaWIwRDFmSmFtaitjbG1PNW5xTnlKRXQzWUg0Z3lWcEFpSFBxZ2VoVExY?=
 =?utf-8?B?OUx2VHg2Nm54VmJCNnV0ZjhGVTFDT1VYQWE2YjhZRVcrRlhCWWUyd0hNUFl5?=
 =?utf-8?B?QTR1ZndqQmFWdmpqU3NTNEsra3MxdHJBK0o0RXMrVGRrM3hiSER3OVY4WVZ3?=
 =?utf-8?B?WFBZdHZjN3dwRTQ5bDB0ckZ5K2FlSXNrcWZaN0ZaRmRpdzBPUVhvN21ZZVli?=
 =?utf-8?Q?0mtfV1accnLUl5W+tE+PjNTr6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7158b13d-57f0-4eb5-cb0d-08dd995e8cac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:29:12.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb3CYy44I+xnA0akTrSkukO57108YrgRIIsRCraPukzaFJxI3oX4XSqCdvHmhVnIjb/kaPq0tdrCZLcFsNNjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10273

On Thu, May 22, 2025 at 03:16:11AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2025年5月21日 23:56
> > To: Luke Wang <ziniu.wang_1@nxp.com>
> > Cc: Bough Chen <haibo.chen@nxp.com>; adrian.hunter@intel.com;
> > ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > imx@lists.linux.dev; dl-S32 <S32@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not change pinctrl state in
> > suspend if function irq is wakeup source
> >
> > On Wed, May 21, 2025 at 11:31:34AM +0800, ziniu.wang_1@nxp.com wrote:
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > pinctrl sleep state may config the pin mux to certain function to save
> > > power in system PM. But if usdhc is setting as wakeup source, like the
> > > card interrupt(SDIO) or card insert interrupt, it depends on the
> > > related pin mux configured to usdhc function pad.
> > > e.g. To support card interrupt(SDIO interrupt), it need the pin is
> > > config as usdhc DATA[1] function pin.
> >
> > I think it should be dts settings wrong. Does one PAD set as function impact
> > power much?
>
> Hi Frank,
>
> I double check the power team, on imx93-11x11-evk board, For SD card on usdhc2, switch the PAD to gpio function will save about 3~4mw,
> For SDIO wifi on usdhc3, switch the PAD to gpio function will save about 0.8~1mw. (without wakeup)

Okay, I think it should be add new pinctrl state ("wakeup"), only set DATA[0,2,3]
to GPIO and SET DATA[1] to sd function.

You can change pad setting to "wakeup" state if wake up enabled.

Frank

>
> Regards
> Haibo Chen
> >
> > Frank
> >
> > >
> > > Find the issue on imx93-11x11-evk board, SDIO WiFi in band interrupt
> > > can't wakeup system because the pinctrl sleep state config the DATA[1]
> > > pin as GPIO function.
> > >
> > > For this case, do not change the pinctrl state in suspend.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 5f1c45b2bd5d..f206b562a6e3 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -2057,12 +2057,20 @@ static int sdhci_esdhc_suspend(struct device
> > *dev)
> > >  		ret = sdhci_enable_irq_wakeups(host);
> > >  		if (!ret)
> > >  			dev_warn(dev, "Failed to enable irq wakeup\n");
> > > +	} else {
> > > +		/*
> > > +		 * For the device which works as wakeup source, no need
> > > +		 * to change the pinctrl to sleep state.
> > > +		 * e.g. For SDIO device, the interrupt share with data pin,
> > > +		 * but the pinctrl sleep state may config the data pin to
> > > +		 * other function like GPIO function to save power in PM,
> > > +		 * which finally block the SDIO wakeup function.
> > > +		 */
> > > +		ret = pinctrl_pm_select_sleep_state(dev);
> > > +		if (ret)
> > > +			return ret;
> > >  	}
> > >
> > > -	ret = pinctrl_pm_select_sleep_state(dev);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > >  	ret = mmc_gpio_set_cd_wake(host->mmc, true);
> > >
> > >  	/*
> > > --
> > > 2.34.1
> > >
