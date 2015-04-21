From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/4] PM / QoS: Add pm_qos_cancel_request_lazy() that
 doesn't sleep
Date: Tue, 21 Apr 2015 11:26:50 +0300
Message-ID: <553609CA.8000806@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>    <1427204440-3533-2-git-send-email-adrian.hunter@intel.com> <03394129c3ef5958dcfbe3726959ecd1.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <03394129c3ef5958dcfbe3726959ecd1.squirrel@www.codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
To: Dov Levenglick <dovl@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/04/15 17:00, Dov Levenglick wrote:
>> Add pm_qos_cancel_request_lazy() which is convenient for
>> contexts that may not sleep.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  include/linux/pm_qos.h |  2 ++
>>  kernel/power/qos.c     | 20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index 7b3ae0c..f44d353 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -126,6 +126,8 @@ void pm_qos_update_request(struct pm_qos_request *req,
>>  			   s32 new_value);
>>  void pm_qos_update_request_timeout(struct pm_qos_request *req,
>>  				   s32 new_value, unsigned long
>> timeout_us);
>> +void pm_qos_cancel_request_lazy(struct pm_qos_request *req,
>> +				unsigned int timeout_us);
>>  void pm_qos_remove_request(struct pm_qos_request *req);
>>
> 
> I think that this could be acheived using existing API if
> pm_qos_update_request_timeout() were to be called with the existing
> timeout value.

I don't follow what you mean. There is no existing timeout value.
Did you mean existing request value? There is still the difference wrt
cancel_delayed_work_sync.

> Since reading the existing timeout value is missing - and I think would be
> a useful feature to have for other use-cases - do you agree with such an
> approach?
> 
>>  int pm_qos_request(int pm_qos_class);
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
>> index 97b0df7..ac131cb 100644
>> --- a/kernel/power/qos.c
>> +++ b/kernel/power/qos.c
>> @@ -517,6 +517,26 @@ void pm_qos_update_request_timeout(struct
>> pm_qos_request *req, s32 new_value,
>>  }
>>
>>  /**
>> + * pm_qos_cancel_request_lazy - cancels an existing qos request lazily.
>> + * @req : handle to list element holding a pm_qos request to use
>> + * @timeout_us: the delay before cancelling this qos request in usecs.
>> + *
>> + * After timeout_us, this qos request is cancelled.
>> + */
>> +void pm_qos_cancel_request_lazy(struct pm_qos_request *req,
>> +				unsigned int timeout_us)
>> +{
>> +	if (!req)
>> +		return;
>> +	if (WARN(!pm_qos_request_active(req),
>> +		 "%s called for unknown object.", __func__))
>> +		return;
>> +
>> +	schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
>> +}
>> +EXPORT_SYMBOL_GPL(pm_qos_cancel_request_lazy);
>> +
>> +/**
>>   * pm_qos_remove_request - modifies an existing qos request
>>   * @req: handle to request list element
>>   *
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
> 

