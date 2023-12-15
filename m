Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB219441
	for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2023 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkYKlicv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702631020; x=1734167020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mOL+vEK4Ji+HG16Xw8nQ6HxXeMudKPy/CS7cF5Zf3kE=;
  b=PkYKlicviZn+0g5aSGrASKCwOO2WbPmxU0s1Omp0fUreTC7Vat3seRFR
   Y2bcznLgPFjm9ulC19beEYVdomMVaGbG8J85xzXgRRoBwO1V14wMnBDdA
   fmbvUiexao/A+QnYmZ7WPzJTNSn5Lg/Pmh5TkdKJ/Z1v4/EOkBmWMeLsY
   0UDRU/2x/rv7exCn4vudwqBOFUCAyUKf8skOui0mIlAvr7GYyyms8ufim
   UO7KWBNEYb680DJWPGyde/C1jbQxXnP72C4Ed6yHoqvgmP5x93CAQ0YsI
   WKbAgA4JlVS1OV/b+UnE6qDagkYo2kY76ZL97cP/6uJKzW5JsvqTHhJI7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2091555"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2091555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 01:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="22755349"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 01:03:36 -0800
Message-ID: <16b0353d-c892-452f-adfd-dba8fdb740e6@intel.com>
Date: Fri, 15 Dec 2023 11:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mmc_test: Add re-tuning test
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "jorge@foundries.io" <jorge@foundries.io>,
 "christian.loehle@arm.com" <christian.loehle@arm.com>,
 "ricardo@foundries.io" <ricardo@foundries.io>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20231214090902.43628-1-adrian.hunter@intel.com>
 <DM6PR04MB6575F0CE62C510DB2853D404FC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575F0CE62C510DB2853D404FC93A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/23 10:45, Avri Altman wrote:
>> +static int mmc_test_retuning(struct mmc_test_card *test) {
>> +       if (!mmc_can_retune(test->card->host)) {
>> +               pr_info("%s: No retuning - test skipped\n",
>> +                       mmc_hostname(test->card->host));
>> +               return RESULT_UNSUP_HOST;
>> +       }
>> +
>> +       return mmc_test_rnd_perf(test, 0, 0, 8192, 30, 1);
>>  }
> I wonder if it would make sense to make a RPMB flavor for the re-tuning test?

Perhaps, but maybe that could be done from user space / mmc-utils.

> 
> Thanks,
> Avri
> 
>>
>>  /*
>> @@ -2921,6 +2934,14 @@ static const struct mmc_test_case
>> mmc_test_cases[] = {
>>                 .run = mmc_test_cmds_during_write_cmd23_nonblock,
>>                 .cleanup = mmc_test_area_cleanup,
>>         },
>> +
>> +       {
>> +               .name = "Re-tuning reliability",
>> +               .prepare = mmc_test_area_prepare,
>> +               .run = mmc_test_retuning,
>> +               .cleanup = mmc_test_area_cleanup,
>> +       },
>> +
>>  };
>>
>>  static DEFINE_MUTEX(mmc_test_lock);
>> --
>> 2.34.1
> 

