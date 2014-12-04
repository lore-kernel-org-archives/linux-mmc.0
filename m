From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [RFC PATCH 0/4] Command Queueing Support in eMMC
Date: Thu, 04 Dec 2014 17:18:34 +0530
Message-ID: <54804A12.1060506@codeaurora.org>
References: <cover.1417519249.git.asutoshd@codeaurora.org> <CAPDyKFowih_NUhAuPhjbe2x5F9ZtAocjgstTGtO1TDMKq3ytjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:39913 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbaLDLsk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Dec 2014 06:48:40 -0500
In-Reply-To: <CAPDyKFowih_NUhAuPhjbe2x5F9ZtAocjgstTGtO1TDMKq3ytjA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

Hi Ulf

On 12/4/2014 4:53 PM, Ulf Hansson wrote:
> On 2 December 2014 at 12:53, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> In this patch series, we propose a method to add support for
>> Command Queueing(CQ) feature added to eMMC-5.1 specification.
>> This feature includes new commands for issuing tasks to the
>> device and orders the execution of tasks to the device. It
>> also has task management functions.
>>
>> The initialization of CQ is decided based on the underlying
>> driver capability and the capability advertised by the card
>> through ext_csd.
>>
>> We have selectively adopted the scsi design of pulling in
>> requests from kernel block layer.
>>
>> In order to support queueing of multiple requests, we have
>> added a new issue function to mmc-queue. This selectively
>> pulls the requests and prepares and issues it to the underlying
>> driver. We have used the inherent tagging mechanism of kernel
>> block layer to keep track and map tags to the slots of underlying
>> driver. The current design doesn't block for the request to
>> complete. We have separated the issuing and completion path
>> of the request and tracking is done using the tag assigned to
>> the request.
>>
>> We have introduced a number of APIs to mmc block layer to
>> facilitate servicing of requests.
>>
>> The completion of requests is handled in a softirq registered
>> with the kernel block layer during initialization. The error
>> handling however would be done using a workqueue and is under
>> development.
>>
>> We have separated the legacy eMMC code from CQ code, so as to
>> make it more manageable.
>>
>> A new layer has been introduced to serve the CQ compliant drivers.
>> This layer (cq_hci) has all the standard functionality implemented.
>> It also has necessary hooks for convenience of platform drivers.
>
> Hi Asutosh,
>
> Thanks for posting this patchset! It's an interesting feature eMMC 5.1
> has adopted. I also hope to get some input from several other
> reviewers around this patchset.
>
> Let me start by give some generic initial feedback:
>
> 1) I think we have earlier merged/reviewed code for new eMMC/SD
> features, without demanding excellent code quality. I will not let
> that happen again, just so you guys know. Nothing said about this
> patchset as such!
>
> 2) Earlier we have accepted to add new features without these being
> properly validated on HW. The result is that we might have dead code,
> since it's hard to tell whether is actually used and thus working. I
> will demand all features to be tested on HW before I merge them. I
> guess that won't be an issue here, right?

I understand. Testing it on HW won't be an issue.

>
> 3) Adding new big features shall be thoroughly justified. In this
> case, showed by improved performance. Such performance statistics
> shall in this case have the reference from a host driver that supports
> the asynchronous request mechanism. So, if your host driver doesn't
> support that currently, that's the first thing you should be looking
> into.

Currently, it does support asynchronous request and the performance 
would be compared with that.

>
> I will get back to review the actual patches as soon as I can.
>
> Kind regards
> Uffe
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
