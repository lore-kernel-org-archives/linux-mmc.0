Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694501EB3E;
	Wed,  5 Feb 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727374; cv=fail; b=VTAuSV4e/R2WRIBcK2Ww1xVZ+zOEb7na7Rd9RwSVlHet+UF9qUQ7/tB5fYgXqMChyAx8hbgOtbCorY63745VOGeLEPhTSgJNEy7LbuohTAZT0KdRrsMX7Ci9mo7Aw3kXiAmWdu63LB0Vep+69KxJ18QnqshWvoEmvhSxG857IjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727374; c=relaxed/simple;
	bh=hLOluupkc+QGfTy5EBhsXgO78JOIMwCjL0FAEwh/yII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uc4s+KDgZlh4RMzg6BggZCjwMLSWrTiz2IluK1g48d/QU47ZODscVdc2yvj64RQpT33vhN/yvx6ErJmcVFESRN+M83kTMQTAe/HwhkDqfDL8SbFLIprHzJMhufJy2sInyVTTRY7n9l6By/+0Cwco4Tww16RX2ZQQZHwAdXmExmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L5VwZWCE; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L5VwZWCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PASg62vBZS8Nq//P5Ba022swB5KGJ1q34ZryuEQGGzG1Gts/NIPluloLTqn8lSwdYTebxbRRhZa0hqJyc57QNEHk4zDA0ht64x0xds62EUbsKwsm2Bb7LjR397I9lu7wvGc0v9hewsMVeapSX4ovyNbBKP3DOsTvj3+L58sHw23TXmvWvNeEUw7BKhciCEM3RPj3ntnfbRcJoRnNsp/5vzYVJFVemPoAlQLyTLnHTpBWgYD3Wu26erpqCKIYeAY7SMA/gXhuRpYKoiVp5R/TT3OWPDNlBUuHNJqtKRMMmoJLG/alqWHBWUP09TdMNTHbVrR8u4WJeh0+RiUnuFblkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLOluupkc+QGfTy5EBhsXgO78JOIMwCjL0FAEwh/yII=;
 b=e36NyQhCeNz3MbU85UEtleZlA/9rxA464vUTt343Q5EYqYUnQgc7QzAjEvYdugmkWOlAfXFhHZ/i24h6sr8Jqa4qGfr1UzyHtnc2seVdJgin76ERr8QGuOU1ehiPSG79TkGwdHdIoSOhlOlhgPjRYmADE5/4QsRUX2USGvBfIx75VDi8EwDtMZCtswaVhMUrmVJEd2BRxTBunRjDwtfqq/YwXv0pJwIdZ3ScQ6QqpXfcLhONLDge5SaW7lqF2V7B7q3hnZzDH4FynETUQvcpR6nKcpFXTVyu6Cv+Kvq6RmPMYG81CSuNjisOYVNljdoZjphO77ym1ceQ5yNO6qU/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLOluupkc+QGfTy5EBhsXgO78JOIMwCjL0FAEwh/yII=;
 b=L5VwZWCElNi9CXAqOO+TGPo7IE0Ha2aRa1J9XQ6Gri1XRKqjsr6yu0hPSpGLMegYRGXHABK79csJL49q5iyEpIJ6ntr5IAMEq6j8ngshIdCc7tj+ShMvVASJ1AMDf+2jLrW9fZ2davAZNc9qU05HNiVRJxcbNLd81c+8KtRT5VMBlcpSum5Z/lO4CIjccrq+PMtV6AupvDm1JX8oPUXU6jOZdP0wvAtAzwGmYdT5TbBYyHUOhW+3NowBQORGavz9HU/k/B/GKJyjaMGPLDlnr4RhepB2IN4W0iA4KB9tZi7wPshcIdcSEGmrd8ZxKkSjvINPiQJa/iRDZCPHfw265A==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:49:27 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 03:49:27 +0000
From: <Dharma.B@microchip.com>
To: <neil.armstrong@linaro.org>, <robh@kernel.org>, <conor@kernel.org>
CC: <ulf.hansson@linaro.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Topic: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Thread-Index:
 AQHbUcwFXFHAxHVg1UOmapSBwIyZUrLuAKyAgBzF3oCAAR0SAIAAbuaAgAEpg4CAEch5gIAXkSEAgABAU4CAAUhcAA==
Date: Wed, 5 Feb 2025 03:49:27 +0000
Message-ID: <e99b2706-d5c1-4fb7-baed-99a187701baf@microchip.com>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
 <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
 <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
 <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
 <779651f3-e5d4-4de8-878a-84653735e5cb@microchip.com>
 <f312c7ff-8d9b-4317-a75b-ce3d0f94a7ae@microchip.com>
 <3ecf58f4-38c0-4435-899a-400df62f5d51@linaro.org>
In-Reply-To: <3ecf58f4-38c0-4435-899a-400df62f5d51@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM4PR11MB6455:EE_
x-ms-office365-filtering-correlation-id: f798392e-8b03-4c61-b197-08dd459816d8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDhtZVZzVGdOYUtSMnpSQ0FDa1p6WUFGSC9JUFNtT2JVVFZKZ0Q5dENpQ2tK?=
 =?utf-8?B?aTl2UWJ5ampMZkQzQzd5dHdhZ2RyVi92QndNRmkrbXUrWDFYdXg4Q2tGcjNJ?=
 =?utf-8?B?cFZ4RzFvV0ZOalZvNDR6RG1Idk1TY2RIbFRzb09GWWFqQzg0U1lPOXlxVVBu?=
 =?utf-8?B?Mis1bUVHZXJFcTNFNGlsNVZ4ZFdDL3pkdEo2b0MzeFJyaWJYN1h3MXViY2tw?=
 =?utf-8?B?M3BrN05hK1dkM3NhN2JSeW41OURZRkwvaHJnc1FoN1QwYWN3VUpsdzJYSlZZ?=
 =?utf-8?B?dzRXSnREWjRrTjRyZXo0T3dZQU15STY0WTNvSVo2MHkya0xOTzRDMkFVT21Y?=
 =?utf-8?B?TGFUSEs4d2VJU0JmTkJGanJFYUN1MHMwZjh6TmdDeVRGQjRocFFZbldVRmlo?=
 =?utf-8?B?aXM1WFkxWnJqRjlZdHJXalRTaGtvNzRYQVdBU3ZLdHRMb00ySSttMWFmNlZY?=
 =?utf-8?B?MWxxTWk5UGJqZVYyZ3ZJODgrQXB0SXVwMnc2NzZoelpPa3pMdmtrUUdMaU1w?=
 =?utf-8?B?azNrVFhYTUpscUJWT0tKWXZMN25mcXo2WXkyQktvTEVQVzlBMzBhMlV1aldY?=
 =?utf-8?B?cW5FYk1BeHVNQUVPamNhdUtmWThLY2tOY1FDa2kycW9VcWZxZ256U3RlU0hO?=
 =?utf-8?B?djRMcGZxbkNGRXQrd1Q2TzVmT25LTy9pWVpsdDJaL0RmS1ptZktFOHBoWGNQ?=
 =?utf-8?B?czB6ekl4YTVUaTZlaEJqeHBVUzhOZFFIL0loTU1YUzVCR2tkUTNKL0lZMFAy?=
 =?utf-8?B?M3ZQa3cwNWZxM1hlTmFpcmN2OVZOSzZRN0V4N1JmVlNuUGJJUVJXYTl1VUF2?=
 =?utf-8?B?UlY1WW12WFkxaVJZZi9jUWE2aytoU09NZlVOV2hDZGRJeGJTTFpZL3BkbEtz?=
 =?utf-8?B?UG4zK1BYam8xWTUxMDRYdmdJR0JSNUIwMEQ3N2tPWER4QUt4MWYwVVIveHR3?=
 =?utf-8?B?U2gzYjVQalpxdWVOVkswTVVudjIxZzAxSTdZbXN3OGFNWUVRMVNkWnZJTXYx?=
 =?utf-8?B?d09jTEpBenYzZDlMUkYyRk94RVgzWHVCZXBBbXQ5bVdNaENidW52RFQrencx?=
 =?utf-8?B?dXJzaU1BWlFzRWtqZ0QyVkR1a2lvaEVtbzFzbzlnTEplSHlrczZuN0Vhanl3?=
 =?utf-8?B?Y1B5S2w3eVEvUldmWHJPZlV1UStkWXpGQlRnbmhBajdSemNtU2l2cHpqZi9G?=
 =?utf-8?B?eHBuUzV5MjI3aGFjNFJGekI1MUpUcUkxZXBONVN0WHNiNXRnWmhpWlloOUNn?=
 =?utf-8?B?RHNiT2kyd2ZHOEREVW05NDYxWXR1VkRRVHFaaVpMSFVvWEM2WmVNV2RZK3Bo?=
 =?utf-8?B?QWU0SGZYWURtS01rMWRNdVJISFlXNVA5c1hCMmJIb1dodUdmaVhjVU9uMm9B?=
 =?utf-8?B?UUk3UmszT1RyY01YeXZjQzZScUdST21RQmRXZlREVUpNSTEzd2FuaGlGK1Fl?=
 =?utf-8?B?WERrcGF0S2tSbXNIRTNpYWxwYjNYcDBvcGhmQlN5WHZUVS8zRGduTitIYmZl?=
 =?utf-8?B?cVJRRHFxRHJWbWVzWDQraFFyMjd5M1lqZU5WUFJpYm9kMUFpSEJybVY1OTJE?=
 =?utf-8?B?TzVnMWRPVEUyV0YyekU4S1RCZThvZ1h3NDVlcDZxV0dkU3dXZ24reEovNVZK?=
 =?utf-8?B?YmhSUWtNdi9VbzFWQkhZdlNON2tNNkhCYzdvZVJJaXE1dEthcmlFMXg2WmVs?=
 =?utf-8?B?cTg3Q1VaSkFUVmpWeU1keHAyR09uRVdnRFNEc1BzN2toZG9Bc3pReGFSdEtL?=
 =?utf-8?B?RnF0c3A1ZHRGTmUyRGY0SUNZRXIxK29vdkR3Sk9ubzJxM0UxbmxwQ0tWeHNh?=
 =?utf-8?B?aHFYTHVZMDZvSEFtZkx0WkJmS3Y0cU11YWxZZ2s4VERzaWRMdC9mSWwzMWpj?=
 =?utf-8?B?OWg0bkN4VEJOVG15ajQyK0w0SVErUklQYmRVQUhKZ1k2ZUZOTmlSREdzd3lj?=
 =?utf-8?Q?hakzPPTj/FCpaM/vtWXCHZiGeYCIIcMd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TndiK3UrYXZPQXBZb0lNc2tHSHZReWZIOEgzek0zbGRwYkN1MTF2VWRjb043?=
 =?utf-8?B?Y25CTzhGNkZFSjFiUFJmdVRtYXo3RUhtc3FlZnRCelhpajI5d1lXRWtiR3FC?=
 =?utf-8?B?c1lDMTZkclMrQUJHRDVyU2hyU2pTVVBqSlc1RS9MQUprVzNpVWJIdFIxYTRY?=
 =?utf-8?B?UHlRNWFRZ0lXemZTakhHRjBCN2gza3F3VDYxY2N0b0tidndQcXlndHZYV2di?=
 =?utf-8?B?b0V4anNFeVpGTEVmTHZob1pLVDM1bEpRQ2plQitTQnhUd3FpeGYrWUh6YzUv?=
 =?utf-8?B?TFh0alZ1QVhjZVNyL1crbTJ6TGpaN0lRcTVOQnFZWjNsUUVwdm4xZmpWMWRn?=
 =?utf-8?B?TGo5cDNJTXU1U3JhRHA5M2tjSW1HbHVSaDhteWhySVlxTWJPSWVpbnFBb05R?=
 =?utf-8?B?eFp5aVc4Vi9kZDlJbDlNQWlyTFQ0VXQrYm1OcWI5M0E3bXVlMlgyM3Jhek1H?=
 =?utf-8?B?a3FGRCtlelcvQ1NoVWQySHhIcGs2MnEvNnRnQnRCMzZ5YldqODMrcFloWWZQ?=
 =?utf-8?B?OUZacGl4T096V2ovR2ltRlJOTmIzY1Vsc2p6UzQySnhNRFFEeEZaSGwyMUEx?=
 =?utf-8?B?NllOVlN4WDg1NGU5RnNjSzBJU1BHb2tvUW5uQUpxbEtYQVJNWG9RWWlnaEtk?=
 =?utf-8?B?czBRYmp1em91OHlsTnQxS1RLZ3RnTTNMNjQ5MDkrTlcyOGF5L0oycHdTK3pE?=
 =?utf-8?B?VjlqSWIyVWZ4bEl1aTlJMmlBalJaeUdReUhlUkhXQ0Q4R25NckNCRUJGWkdE?=
 =?utf-8?B?WjZ1cGJEMkxGd3pwS0w4UGJLbHJQY1F6b1BpNVc5UldPMHgwcjhoc29yYWF5?=
 =?utf-8?B?c2RyWkRxNTR0OExGd0oybVgzQnRBeG90eXp2Y2wzR0ozZzNQU0hjWFNvUERC?=
 =?utf-8?B?UVQwdHUvaGpDVlMxYmVHTmtrdGYxUko5alNDUmIvUnpiQmoxWnJIdFF3RVNE?=
 =?utf-8?B?cWVrUUZud2ZxUXRKRlBLRVdlNGFBU1A4aGVMNnlHaFdVTUJsQ0RnQURjRVdW?=
 =?utf-8?B?YStxWHdqcWtIV1lxQ1VMQlhidkt3alNBeEl6RHp5Ky9ZcGZCcHorNmk2TW9q?=
 =?utf-8?B?Q1lZcWtIV2xRS3pIVjZrUm1wbnlVMGdzSTQzWEs0NkVIL0U4SkFpdkZieTVD?=
 =?utf-8?B?ZG5RcU1DM0EyY3BLU1Q5Z3JudWpKVGcva3krTkZVQTJycDZHUUc5d3NNMlQr?=
 =?utf-8?B?YzhERlg4M1d3anJuWnAxU2s5Qk9ObWZ0TTdlRUREL1BPUU53aTA1WDBrQ2lQ?=
 =?utf-8?B?TGZGMVl1cUpsZm1PcDFBNDNnZnJDVFFjaEQ3MmhoUUpRRUpENmU1anIyS3o3?=
 =?utf-8?B?ZytWYjlrVFcrbTd1Vlg1YTJsR01YcmJ0REhNSjQ0YysvTENONkphWWFBc1JD?=
 =?utf-8?B?L2ZuZnU3Tk04QTlFVElpbEdRYy9YUkZxQmJYTk9CUkFvQjNwNDIzYjJqSEdL?=
 =?utf-8?B?c2Vkek9sQkx3OFNVMHdiUUFsSWpVUWtSRWExNS9qRldOam52VnFQMHNYZTFH?=
 =?utf-8?B?dTI0bWh2d0pLZHlMeTFYdUVQUWZCSVp6YVZabDFtS1dkaHEzZXlWUGpNSE42?=
 =?utf-8?B?Wm05ZjZjb2FrTmN5Z3FSbllsazllbUpRZ0pncUtVeitMZ0RMWGMzaGhhVVoy?=
 =?utf-8?B?S09DbU5sT3c1eGpFTFlEd1hzS0puaGU1anJqY3ovVXpNbkdkdWVsTUVkRmJK?=
 =?utf-8?B?QU5DUXhuY3ZtekxZc1Y0N0RVdld1V1JOY3Q4ajVUMnc2VXVYdVNuREJhV1ha?=
 =?utf-8?B?Y0NGV01KS1VTWGhvaWRQWWs4aHZnSHdkTlU5Y2ZUNVZUcXRMZDh4VU1rWWhj?=
 =?utf-8?B?aExDVEZHZnhyQVJieXMxcWtTeU9ZV3BZc05yaFdWbWFpS3FrR0tBL3had3h4?=
 =?utf-8?B?WDZacU5Jb0Y3MkQyZU4wajFnbE5CQlRKcE1hdFdkdmdtdjR4blh2U3FLYlpp?=
 =?utf-8?B?RWpnQm1iOUNTRGdaZ0prUENKNjBqUDczUXZ2VHVvMzluTlVLWmJ1ZDBIcjkr?=
 =?utf-8?B?aDhheENzaVFhaDdJSHFVTkVPd2lsWUVmaC9Nb0g3KzNia1BRcUZQV2ozd3Rj?=
 =?utf-8?B?WXkwNExhRXJYNDlZSWpYamZqK3QrbVZBZ040VXU2aFhHenNhUmFCQ3hSQVFx?=
 =?utf-8?Q?0eADUz3hxxQy5J+Zj94HRN+CO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <844792C2911B5948937EA2E4447C657E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f798392e-8b03-4c61-b197-08dd459816d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 03:49:27.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: de7GgpqOyqptYLJLeBgtswpOd99rFJq3ppfgJ1gzT92VzalyihWVjwihtRL8lj3v/hriN0Mfl3DstKATY8xb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455

T24gMDQvMDIvMjUgMTo0NCBwbSwgbmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZyB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBP
biAwNC8wMi8yMDI1IDA1OjI0LCBEaGFybWEuQkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gUm9i
IC8gQ29ub3IsDQo+Pg0KPj4gT24gMjAvMDEvMjUgMTA6MDAgYW0sIERoYXJtYSBCIHdyb3RlOg0K
Pj4+IEhpIFJvYi9Db25vciwNCj4+Pg0KPj4+IE9uIDA5LzAxLzI1IDI6MjYgYW0sIE1hcnRpbiBC
bHVtZW5zdGluZ2wgd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+Pj4gdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+Pg0KPj4+PiBIaSBEaGFybWEsDQo+Pj4+DQo+Pj4+IE9uIFdlZCwgSmFuIDgs
IDIwMjUgYXQgNDoxMeKAr0FNIDxEaGFybWEuQkBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pj4g
Wy4uLl0NCj4+Pj4+ICJPbmUgaXNzdWUgaXMgJ2NvbXBhdGlibGUnIGlzIHJlcXVpcmVkLiBFaXRo
ZXIgdGhhdCB3b3VsZCBoYXZlIHRvIGJlDQo+Pj4+PiBkcm9wcGVkIGFzIHJlcXVpcmVkLiINCj4+
Pj4+DQo+Pj4+PiBJbnN0ZWFkIG9mIGp1c3QgZHJvcHBpbmcgaXQgZnJvbSAicmVxdWlyZWQ6Iiwg
SSByZW1vdmVkIHRoZSBwcm9wZXJ0eQ0KPj4+Pj4gaXRzZWxmIGFuZCBtb3ZlZCBpdCB0byBhbm90
aGVyIGJpbmRpbmcuDQo+Pj4+Pg0KPj4+Pj4gSSB3aWxsIHNlbmQgYSB2MiBieSByZW1vdmluZyBp
dCBmcm9tIHRoZSByZXF1aXJlZCwgd2lsbCBpdCBiZSBmaW5lPw0KPj4+PiBGb3IgbWUgdGhpcyBp
cyBmaW5lLg0KPj4+Pg0KPj4+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaWYgd2UgZHJvcCB0
aGUgY29tcGF0aWJsZSBwcm9wZXJ0eSBjb21wbGV0ZWx5DQo+Pj4+IHRoZW4gYW55IGNvbXBhdGli
bGUgc3RyaW5nIHdpbGwgYmUgYWxsb3dlZCAoZm9yIGV4YW1wbGU6IGNvbXBhdGlibGUgPQ0KPj4+
PiAicmFuZG9tLG5hbWUiKS4gVGhpcyBpcyBiZWNhdXNlIG1tYy1zbG90LnlhbWwgaW5oZXJpdHMg
dGhlIHByb3BlcnRpZXMNCj4+Pj4gZnJvbSBtbWMtY29udHJvbGxlci1jb21tb24ueWFtbCB3aGlj
aCBpdHNlbGYgaGFzDQo+Pj4+ICJhZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZSIuDQo+Pj4+IEhv
d2V2ZXIsIGlmIHdlIGFsbG93IGl0IGJ1dCBtYWtlIGl0IG9wdGlvbmFsIGl0IG1lYW5zIHRoYXQg
dGhlcmUncw0KPj4+PiBvbmx5IHR3byB2YWxpZCBzdGF0ZXM6DQo+Pj4+IC0gbm8gY29tcGF0aWJs
ZSBwcm9wZXJ0eSAob24gdGhlIEF0bWVsIC8gTWljcm9jaGlwIFNvQ3MpDQo+Pj4+IC0gYSBjb21w
YXRpYmxlIHByb3BlcnR5IHdpdGggdGhlIHZhbHVlICJtbWMtc2xvdCIgKGFzIHVzZWQgb24gQW1s
b2dpYw0KPj4+PiBNZXNvbiBhbmQgQ2F2aXVtIFRodW5kZXIgU29DcykNCj4+Pj4gLSAoYW55dGhp
bmcgZWxzZSBpcyBjb25zaWRlcmVkIGludmFsaWQpDQo+Pj4+DQo+Pj4+IFJvYiwgQ29ub3I6IGNh
biBjb25maXJtIHRoaXMgb3IgY29ycmVjdCBtZSB3aGVyZXZlciBJIGdvdCBzb21ldGhpbmcNCj4+
Pj4gd3JvbmcuDQo+Pj4+IEkgaG9wZSB0aGF0IHlvdXIgZmVlZGJhY2sgd2lsbCBoZWxwIERoYXJt
YSB3cml0ZSBhIGdvb2QgcGF0Y2gNCj4+Pj4gZGVzY3JpcHRpb24gZm9yIHYyLg0KPj4+DQo+Pj4g
U2hhbGwgSSBwcm9jZWVkIHdpdGggdjIgYnkgZHJvcHBpbmcgdGhlIGNvbXBhdGlibGUgZnJvbSB0
aGUgcmVxdWlyZWQNCj4+PiBwcm9wZXJ0eSBsaXN0Pw0KPj4NCj4+IEkgaG9wZSB0aGlzIGVtYWls
IGZpbmRzIHlvdSB3ZWxsLiBKdXN0IGZvbGxvd2luZyB1cCBvbiBteSBwcmV2aW91cw0KPj4gbWVz
c2FnZSBmcm9tIDIwLzAxLzI1LCBhcyBpdCBzZWVtcyB0byBoYXZlIGFjaGlldmVkIGFuIGltcHJl
c3NpdmUNCj4+IGZlYXTigJRwZXJmZWN0IHN0ZWFsdGggbW9kZS4gRWl0aGVyIG15IHBhdGNoIGlz
IHNvIGZsYXdsZXNzIHRoYXQgaXQgbGVmdA0KPj4gZXZlcnlvbmUgc3BlZWNobGVzcywgb3IgaXQg
aGFzIGJlZW4gc2lsZW50bHkgc2FjcmlmaWNlZCB0byB0aGUgaW5ib3gNCj4+IGdvZHMuIPCfmIUN
Cj4+DQo+PiBJZiB0aGVyZSBhcmUgYW55IGNvbmNlcm5zLCBmZWVkYmFjaywgb3IgYSBzZWNyZXQg
cml0dWFsIEkgbmVlZCB0bw0KPj4gcGVyZm9ybSB0byBnZXQgYSByZXNwb25zZSwgcGxlYXNlIGRv
IGxldCBtZSBrbm93LiBXb3VsZCBsb3ZlIHRvIGhlYXINCj4+IHlvdXIgdGhvdWdodHMgd2hlbiB0
aW1lIHBlcm1pdHMuDQo+Pg0KPj4gTG9va2luZyBmb3J3YXJkIHRvIGJyZWFraW5nIHRoZSByYWRp
byBzaWxlbmNlIQ0KPiANCj4gSnVzdCBzZW5kIGEgdjIgYXMgUkZDLCBzbyB3ZSBjYW4gY29tbWVu
dCBvbiBpdC4NCg0KVGhhbmtzIE5laWwsIHNlbnQgYSB2MiBSRkMuDQoNCj4gDQo+IFRoYW5rcywN
Cj4gTmVpbA0KPiANCj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+IE1h
cnRpbg0KPj4+Pg0KPj4+DQo+Pj4NCj4+DQo+Pg0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdh
cmRzLA0KRGhhcm1hIEIuDQo=
